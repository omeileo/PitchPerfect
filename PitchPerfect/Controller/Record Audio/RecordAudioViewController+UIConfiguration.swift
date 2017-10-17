//
//  RecordAudioViewController+UIConfiguration.swift
//  PitchPerfect
//
//  Created by Jase-Omeileo West on 10/17/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import UIKit

extension RecordAudioViewController
{
    func resetView()
    {
        recordButtonHeight.constant = 155
        recordButtonWidth.constant = 155
        recordingStackViewYCoord.constant = 0
        recordButton.isSelected = false
        waveformImageView.isHidden = true
        configureAudioRecordingUI(text: "Tap to start recording", imageName: "Record")
    }
    
    func configureAudioRecordingUI(text: String, imageName: String)
    {
        let image = UIImage(named: imageName)
        recordingInstructionLabel.text = text
        recordButton.setImage(image, for: .normal)
    }
    
    func adjustUI()
    {
        UIView.animate(withDuration: 0.4) {
            self.recordingStackViewYCoord.constant = 100
            self.recordButtonWidth.constant -= 90
            self.recordButtonHeight.constant -= 90
            
            self.view.layoutIfNeeded()
        }
        
        configureAudioRecordingUI(text: "Tap to stop recording", imageName: "Stop")
        animateWaveform()
    }
    
    func animateWaveform()
    {
        images = [#imageLiteral(resourceName: "waveform-5"), #imageLiteral(resourceName: "waveform-6"), #imageLiteral(resourceName: "waveform-7"), #imageLiteral(resourceName: "waveform-8"), #imageLiteral(resourceName: "waveform-9"), #imageLiteral(resourceName: "waveform-10"), #imageLiteral(resourceName: "waveform-11"), #imageLiteral(resourceName: "waveform-12"), #imageLiteral(resourceName: "waveform-13"), #imageLiteral(resourceName: "waveform-14"), #imageLiteral(resourceName: "waveform-13"), #imageLiteral(resourceName: "waveform-12"), #imageLiteral(resourceName: "waveform-11"), #imageLiteral(resourceName: "waveform-10"), #imageLiteral(resourceName: "waveform-9"), #imageLiteral(resourceName: "waveform-8"), #imageLiteral(resourceName: "waveform-7"), #imageLiteral(resourceName: "waveform-6"), #imageLiteral(resourceName: "waveform-5"), #imageLiteral(resourceName: "waveform-4"), #imageLiteral(resourceName: "waveform-3"), #imageLiteral(resourceName: "waveform-2"), #imageLiteral(resourceName: "waveform-1"), #imageLiteral(resourceName: "waveform-2"), #imageLiteral(resourceName: "waveform-3"), #imageLiteral(resourceName: "waveform-4")]
        animateImages(images: images, imageView: waveformImageView, duration: 1.75)
    }
}
