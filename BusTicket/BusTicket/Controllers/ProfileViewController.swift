//
//  ProfileViewController.swift
//  BusTicket
//
//  Created by serdar on 10.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    func configure(){
        visualEffectView.layer.cornerRadius = 20
        visualEffectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        visualEffectView.clipsToBounds = true
        logoutButton.layer.cornerRadius = 10
        logoutButton.layer.masksToBounds = true
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
        shadowView.layer.cornerRadius = profileImage.bounds.width / 2
        shadowView.clipsToBounds = false
        
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: profileImage.frame.size.width / 2).cgPath
        shadowView.layer.shadowRadius = 6

    }
    
    @IBAction func onLogoutButtonClicked(_ sender: Any) {
        dismiss(animated: false)
        let contrller = storyboard?.instantiateViewController(withIdentifier: "LoginNC") as! UINavigationController
        contrller.modalPresentationStyle = .fullScreen
        contrller.modalTransitionStyle = .coverVertical
        present(contrller, animated: true)
    }
    
}
