//
//  UIViewController+Utils.swift
//  PitchPerfect
//
//  Created by Jase-Omeileo West on 10/16/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit

extension UIViewController
{
    func animateImages(images: [UIImage], imageView: UIImageView, duration: Double)
    {
        imageView.isHidden = false
        
        let animatedImage = UIImage.animatedImage(with: images, duration: duration)
        imageView.image = animatedImage
    }
}
