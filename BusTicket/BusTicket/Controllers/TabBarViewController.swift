//
//  TabBarViewController.swift
//  BusTicket
//
//  Created by serdar on 9.04.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    @IBOutlet weak var tabBarView: UITabBar!
    
    var fromCity : String?
    var toCity : String?
    var day : Int?
    var month : Int?
    var year : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        if let tripsNC = self.viewControllers?[0] as? UINavigationController {
            
            if let tripsViewController = tripsNC.topViewController as? TripsViewController {
                tripsViewController.fromCity = self.fromCity
                tripsViewController.toCity = self.toCity
                tripsViewController.day = self.day
                tripsViewController.month = self.month
                tripsViewController.year = self.year
                
                }
            
        }
        
        
    }
  



}
