//
//  TabBarController.swift
//  BusTicket
//
//  Created by serdar on 3.04.2023.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet weak var tabbar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabbar.items?[0].image = UIImage(systemName: "house.fill")
        tabbar.items?[0].title = "Tickets"
        tabbar.items?[1].image = UIImage(systemName: "ticket.fill")
        tabbar.items?[1].title = "My Tickets"
        
        
        
    }

}
