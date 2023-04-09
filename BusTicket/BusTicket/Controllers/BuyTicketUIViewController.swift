//
//  BuyTicketUIViewController.swift
//  BusTicket
//
//  Created by serdar on 8.04.2023.
//

import UIKit

class BuyTicketUIViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }        // Do any additional setup after loading the view.
    override func viewDidAppear(_ animated: Bool) {
        if let navigationController = self.navigationController {
            // Geri butonunu göster
            let backButton = UIBarButtonItem()
               backButton.title = "Back"
               self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
           }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
