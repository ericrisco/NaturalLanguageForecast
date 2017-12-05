//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import UIKit
import Speech
import Pulsator
import CRNotifications
import ALLoadingView

class HomeViewController: UIViewController {

    // MARK: - UI attributes
    @IBOutlet weak var machineLabel: UILabel!
    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    
    // MARK: - Speech stuff
    var recognizer: SFSpeechRecognizer?
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    var audioEngine = AVAudioEngine()
    
    // MARK: - Pulsator
    let pulsator = Pulsator()
    @IBOutlet weak var pulsatorImage: UIImageView!
    
    // MARK: - Possible Question Table
    var possibleQuestions: [String] = []
    @IBOutlet weak var titleTableLabel: UILabel!
    @IBOutlet weak var possibleQuestionsTable: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recognizer?.delegate = self
        recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: ReadConfig.value(keyname: ConfigKeys.DEFAULT_LANGUAGE.rawValue)))
        
        initPulsator()
        
        initPossibleQuestions()
        possibleQuestionsTable.dataSource = self
        possibleQuestionsTable.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.layoutIfNeeded()
        pulsator.position = speechButton.layer.position
    }
    
    // MARK: - UI
    
    func reloadUI(){
        self.machineLabel.setTextAnimated(newText: "How can I help you today?")
        self.infoLabel.setTextAnimated(newText: "Push the button to start talking..")
        self.personLabel.setTextAnimated(newText: "")
        showQuestions()
    }
    
    func showQuestions(){
        titleTableLabel.fadeTransition(1)
        titleTableLabel.isHidden = false
        possibleQuestionsTable.fadeTransition(1)
        possibleQuestionsTable.isHidden = false;
    }
    
    func hideQuestions(){
        titleTableLabel.fadeTransition(1)
        titleTableLabel.isHidden = true
        possibleQuestionsTable.fadeTransition(1)
        possibleQuestionsTable.isHidden = true;
    }
    
    // MARK: - Actions
    @IBAction func speechButtonClicked(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        } else {
            self.infoLabel.setTextAnimated(newText: "You can start talking...")
            self.showPulsator()
            self.hideQuestions()
            speechAuthorized(authorized: {
                self.startSpeech()
            }, denied: {
                self.reloadUI()
            })
        }
    }
    
    // MARK: - Navigation
    
    func handleInterval(from: Date, to: Date, values: [NaturalLanguageResponseValues], showTrainingMessage: Bool){
        
    }
    
    func handleValue(datetime: Date, values: [NaturalLanguageResponseValues], showTrainingMessage: Bool){
        
        //Uncomment this line to use Dummy Implementation --> NO NETWORK NEEDED
        //var manager = ForecastInteractor.init(manager: ForecastDummy(), urlString: ReadConfig.value(keyname: ConfigKeys.DARKSKY_URL.rawValue)).manager
        
        //Uncomment this line to use Darksky Forecast Implementation --> NETWORK NEEDED
        let manager = ForecastInteractor.init(manager: ForecastDarkskyAlamofire(), urlString: ReadConfig.value(keyname: ConfigKeys.DARKSKY_URL.rawValue)).manager
        
        let query = ForecastQuery.init(gps_lat: 42.5058524, gps_lon: 1.5189267, date: datetime, units: ReadConfig.value(keyname: ConfigKeys.DARKSKY_UNITS.rawValue))
        
        manager.forecast(query: query, onSuccess: { (forecasts) in
            print(forecasts)
            ALLoadingView.manager.hideLoadingView()
        }) { (error) in
            print(error)
            ALLoadingView.manager.hideLoadingView()
            CRNotifications.showNotification(type: .error, title: "Error!", message: "Something went wrong...", dismissDelay: 3)
        }
        
    }
    
}

