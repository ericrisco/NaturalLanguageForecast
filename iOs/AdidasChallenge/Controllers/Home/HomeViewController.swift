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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recognizer?.delegate = self
        recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: ReadConfig.value(keyname: ConfigKeys.DEFAULT_LANGUAGE.rawValue)))
        
        initPulsator()
        
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
    
    func reloadUI(){
        machineLabel.text = "How can I help you today?"
        infoLabel.text = "Push the button and start talking.."
        personLabel.text = ""
    }
    
    // MARK: - Actions
    @IBAction func speechButtonClicked(_ sender: Any) {
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            reloadUI()
        } else {
            self.infoLabel.text = "You can start talking..."
            self.showPulsator()
            speechAuthorized(authorized: {
                self.startSpeech()
            }, denied: {
                self.reloadUI()
            })
        }
        
    }
}

