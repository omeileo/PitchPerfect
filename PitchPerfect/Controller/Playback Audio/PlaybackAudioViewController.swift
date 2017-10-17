//
//  PlaybackAudioViewController.swift
//  PitchPerfect
//
//  Created by Jase-Omeileo West on 10/15/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import AVFoundation

class PlaybackAudioViewController: UIViewController, AVAudioRecorderDelegate
{
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var toggleAudioPlaybackButton: UIButton!
    @IBOutlet weak var currentlyPlayingAudioImage: UIImageView!
    @IBOutlet weak var currentlyPlayingAudioImageHeight: NSLayoutConstraint!
    @IBOutlet weak var currentlyPlayingAudioImageWidth: NSLayoutConstraint!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int
    {
        case fast = 0, reverb, highPitch, lowPitch, echo, slow
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setupAudio()
    }
    
    @IBAction func toggleAudioPlayback(_ sender: UIButton)
    {
        toggleAudioPlaybackButton.isSelected = !toggleAudioPlaybackButton.isSelected
        configureUI(toggleAudioPlaybackButton.isSelected ? .playing : .notPlaying)
        toggleAudioPlaybackButton.isSelected ? playSound() : stopAudio()
        currentlyPlayingAudioImage.image = #imageLiteral(resourceName: "RawAudio")
    }
    
    @IBAction func playFilteredAudio(_ sender: UIButton)
    {
        stopAudio()
        configurePlaybackControls(button: sender)
        
        switch(ButtonType(rawValue: sender.tag)!)
        {
            case .fast: playSound(rate: 1.5)
            case .slow: playSound(rate: 0.5)
            case .highPitch: playSound(pitch: 1000)
            case .lowPitch: playSound(pitch: -1000)
            case .echo: playSound(echo: true)
            case .reverb: playSound(reverb: true)
        }
    }
    
    func configurePlaybackControls(button: UIButton)
    {
        toggleAudioPlaybackButton.isSelected = true
        button.isEnabled = false
        
        currentlyPlayingAudioImage.image = button.image(for: .normal)
    }
    
    @IBAction func recordNewAudio(_ sender: Any)
    {
        stopAudio()
        _ = navigationController?.popViewController(animated: true)
    }
}
