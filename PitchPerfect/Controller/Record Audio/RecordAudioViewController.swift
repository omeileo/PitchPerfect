//
//  RecordAudioViewController.swift
//  PitchPerfect
//
//  Created by Jase-Omeileo West on 10/15/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate
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
    
    func resetView()
    {
        recordButtonHeight.constant = 155
        recordButtonWidth.constant = 155
        recordingStackViewYCoord.constant = 0
        recordingInstructionLabel.text = "Tap to start recording"
        recordButton.isSelected = false
        recordButton.setImage(#imageLiteral(resourceName: "Record"), for: .normal)
        waveformImageView.isHidden = true
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
    
    func recordAudio()
    {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingNmae = "recordedVoice.wav"
        let pathArray = [dirPath, recordingNmae]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func adjustUI()
    {
        UIView.animate(withDuration: 0.4) {
            self.recordingStackViewYCoord.constant = 100
            self.recordButtonWidth.constant -= 90
            self.recordButtonHeight.constant -= 90
            
            self.view.layoutIfNeeded()
        }
        
        recordButton.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
        recordingInstructionLabel.text = "Tap to stop recording"
        
        animateWaveform()
    }
    
    func animateWaveform()
    {
        images = [#imageLiteral(resourceName: "waveform-5"), #imageLiteral(resourceName: "waveform-6"), #imageLiteral(resourceName: "waveform-7"), #imageLiteral(resourceName: "waveform-8"), #imageLiteral(resourceName: "waveform-9"), #imageLiteral(resourceName: "waveform-10"), #imageLiteral(resourceName: "waveform-11"), #imageLiteral(resourceName: "waveform-12"), #imageLiteral(resourceName: "waveform-13"), #imageLiteral(resourceName: "waveform-14"), #imageLiteral(resourceName: "waveform-13"), #imageLiteral(resourceName: "waveform-12"), #imageLiteral(resourceName: "waveform-11"), #imageLiteral(resourceName: "waveform-10"), #imageLiteral(resourceName: "waveform-9"), #imageLiteral(resourceName: "waveform-8"), #imageLiteral(resourceName: "waveform-7"), #imageLiteral(resourceName: "waveform-6"), #imageLiteral(resourceName: "waveform-5"), #imageLiteral(resourceName: "waveform-4"), #imageLiteral(resourceName: "waveform-3"), #imageLiteral(resourceName: "waveform-2"), #imageLiteral(resourceName: "waveform-1"), #imageLiteral(resourceName: "waveform-2"), #imageLiteral(resourceName: "waveform-3"), #imageLiteral(resourceName: "waveform-4")]
        animateImages(images: images, imageView: waveformImageView, duration: 1.75)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if flag
        {
            performSegue(withIdentifier: playbackVCSegue, sender: audioRecorder.url)
        }
        else
        {
            print("Recording did not go through successfully.")
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

