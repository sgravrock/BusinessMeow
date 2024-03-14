//
//  ViewController.swift
//  BusinessMeow
//
//  Created by Stephen Gravrock on 3/10/24.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    private var soundId: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // didBecomeActiveNotification will trigger on initial launch,
        // so we don't also need to call playMeowOfDisapproval directly.
        NotificationCenter.default.addObserver(self, selector: #selector(playMeowOfDisapproval), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc @IBAction func playMeowOfDisapproval() {
        if soundId == 0 {
            guard let soundURL = Bundle.main.url(forResource: "Meow_domestic_cat", withExtension: "mp3") else {
                print("Audio file not found")
                return
            }
            
            let ret: OSStatus = AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundId)
    
            if ret != 0 {
                print("Loading audio failed with code", ret);
                return;
            }
        }
        
        AudioServicesPlaySystemSound(soundId);
    }

}

