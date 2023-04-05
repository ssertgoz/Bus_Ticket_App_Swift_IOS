//
//  LoginViewController.swift
//  BusTicket
//
//  Created by serdar on 4.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func loginButton(_ sender: Any) {
        if(!nameTextField.text!.isEmpty){
            print("Geldi")
            let contrller = storyboard?.instantiateViewController(withIdentifier: "ChooseNC") as! UINavigationController
            contrller.modalPresentationStyle = .fullScreen
            
            present(contrller, animated: true)
        }
    }
}
