//
//  RecordAudioViewController.swift
//  PitchPerfect
//
//  Created by Jase-Omeileo West on 10/15/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController
{
    @IBOutlet weak var recordingStackView: UIStackView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInstructionLabel: UILabel!
    @IBOutlet weak var recordingStackViewYCoord: NSLayoutConstraint!
    @IBOutlet weak var recordingStackViewXCoord: NSLayoutConstraint!
    @IBOutlet weak var recordButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var recordButtonWidth: NSLayoutConstraint!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func toggleRecording(_ sender: Any)
    {
        if !recordButton.isSelected
        {
            recordButton.isSelected = !recordButton.isSelected
            recordAudio()
            adjustUI()
        }
        else
        {
            //stop recording
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            try! audioSession.setActive(false)
            
            //navigate to playback screen
        }
    }
    
    func recordAudio()
    {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingNmae = "recordedVoice.wav"
        let pathArray = [dirPath, recordingNmae]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func adjustUI()
    {
        UIView.animate(withDuration: 0.6) {
            self.recordingStackViewYCoord.constant = 120
            self.recordButtonWidth.constant -= 90
            self.recordButtonHeight.constant -= 90
            
            self.view.layoutIfNeeded()
        }
        
        recordButton.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
        recordingInstructionLabel.text = "Tap to stop recording"
    }
    
}

