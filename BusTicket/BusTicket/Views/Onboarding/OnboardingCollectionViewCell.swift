//
//  OnboardingCollectionViewCell.swift
//  BusTicket
//
//  Created by serdar on 2.04.2023.
//

import UIKit
import Lottie

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var lottiAnimationView: UIView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    private var animationView: LottieAnimationView?
    
    func setup(_ slide: OnboardingSlide){
        
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.descripton
        
        animationView = LottieAnimationView.init(name: slide.animationName)
        animationView!.frame = lottiAnimationView.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        lottiAnimationView.addSubview(animationView!)
        animationView!.play()
    }
    
}
