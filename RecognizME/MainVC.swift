//
//  MainVC.swift
//  RecognizME
//
//  Created by Saul Rivera on 9/1/17.
//  Copyright © 2017 Dymtech. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class MainVC: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
    }

    func requestSpeachAuth() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                self.speechTransform()
            }
        }
    }
    
    func speechTransform() {
        if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
            do {
                let sound = try AVAudioPlayer(contentsOf: path)
                self.audioPlayer = sound
                self.audioPlayer.delegate = self
                sound.play()
            } catch {
                print("Error!")
            }
            
            let recognizer = SFSpeechRecognizer()
            let request = SFSpeechURLRecognitionRequest(url: path)
            recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                if let error = error {
                    print("The error was \(error)")
                } else {
                    self.transTextField.text = result?.bestTranscription.formattedString
                }
                
            })
        }
    }

    @IBAction func buttonPressed(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeachAuth()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
}

