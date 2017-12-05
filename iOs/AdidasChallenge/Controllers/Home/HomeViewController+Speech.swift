//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import Speech

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
            
            self.personLabel.text = result.bestTranscription.formattedString
            
            if  result.isFinal {
                self.endSpeech()
                self.audioEngine.inputNode.removeTap(onBus: 0)
                //CALL WS
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
        
        infoLabel.text = "Push the button again to stop talking"
        
    }
    
    func endSpeech() {
        audioEngine.stop()
        recognitionRequest = nil
        recognitionTask = nil
        reloadUI()
        hidePulsator()
    }
    
}
