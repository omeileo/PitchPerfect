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
    @IBOutlet weak var waveformImageView: UIImageView!
    
    var audioRecorder: AVAudioRecorder!
    var images: [UIImage]!
    
    let playbackVCSegue = "showPlaybackVC"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        resetView()
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
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == playbackVCSegue
        {
            let playbackAudioVC = segue.destination as! PlaybackAudioViewController
            let recordedAudioURL = sender as! URL
            playbackAudioVC.recordedAudioURL = recordedAudioURL
        }
    }
}

