//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import Speech
import CRNotifications
import ALLoadingView

extension HomeViewController: SFSpeechRecognizerDelegate {
    
    public func speechAuthorized(authorized: @escaping () -> Void, denied: @escaping () -> Void){
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == .authorized {
                authorized()
            }else{
                denied()
            }
        }
    }
    
    func startSpeech() {
                
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = recognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            guard let result = result, error == nil else {
                self.audioEngine.inputNode.removeTap(onBus: 0)
                self.endSpeech()
                return
            }
            
            self.personLabel.setTextAnimated(newText: result.bestTranscription.formattedString)
            
            if  result.isFinal {
                self.audioEngine.inputNode.removeTap(onBus: 0)
                self.takeDecisions(query: result.bestTranscription.formattedString)
            }
        })
        
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
            self.showPulsator()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        self.infoLabel.setTextAnimated(newText: "Push the button again to stop talking")
        
    }
    
    func endSpeech() {
        audioEngine.stop()
        recognitionRequest = nil
        recognitionTask = nil
        reloadUI()
        hidePulsator()
    }
    
    func takeDecisions(query: String){
        
        ALLoadingView.manager.showLoadingView(ofType: .basic, windowMode: .fullscreen)
        
        //Uncomment this line to use Dummy Implementation --> NO NETWORK NEEDED
        //var manager = NaturalLanguageInteractor(manager: NaturalLanguageDummy()).manager
        
        //Uncomment this line to use WIT.ai Implementation --> NETWORK NEEDED
        let manager = NaturalLanguageInteractor(manager: NaturalLanguageWit()).manager
        
        manager.execute(query: query, onSuccess: { (response) in
            self.endSpeech()
            
            if response.values.contains(NaturalLanguageResponseValues.training) {
                // OPTION 1 - User requested if he can train outside
                // Possibles entities -> "training" from possible values [training, jogging, running, ride, outside, ...]
                
                if let has_interval = response.has_datetime_interval, has_interval  {
                    //User requested "training" for datetime interval
                    self.handleInterval(from: response.datetime_from!, to: response.datetime_to!, values: response.values, showTrainingMessage: true)
                } else {
                    //User requested "training" show him current forecast
                    self.handleValue(datetime: response.datetime!, values: response.values, showTrainingMessage: true)
                }
                
            } else if let has_interval = response.has_datetime_interval, has_interval  {
                // OPTION 2 - User requested forecast for a interval datetime
                self.handleInterval(from: response.datetime_from!, to: response.datetime_to!, values: response.values, showTrainingMessage: false)
            } else if let has_datetime = response.has_datetime, has_datetime {
                // OPTION 3 - User requested forecast for a single datetime
                self.handleValue(datetime: response.datetime!, values: response.values, showTrainingMessage: false)
            } else {
                // OPTION 4 - Can't understand what user has requested 😰
                ALLoadingView.manager.hideLoadingView()
                self.machineLabel.setTextAnimated(newText: "I don't understand... 😰")
            }         
            
        }) { (error) in
            print(error)
            ALLoadingView.manager.hideLoadingView()
            CRNotifications.showNotification(type: .error, title: "Error!", message: "Something went wrong...", dismissDelay: 3)
        }
    }
    
}
