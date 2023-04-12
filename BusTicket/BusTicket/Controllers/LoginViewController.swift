//
//  LoginViewController.swift
//  BusTicket
//
//  Created by serdar on 4.04.2023.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func loginButton(_ sender: Any) {
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true

        chectTextFields()
    }
    @objc func chectTextFields() {
        // Text field'ların boş olup olmadığı kontrol ediliyor.
        if userNameTextField.text?.isEmpty ?? true {
            userNameTextField.layer.borderColor = UIColor.red.cgColor
            userNameTextField.layer.borderWidth = 1.0
        } else {
            userNameTextField.layer.borderColor = UIColor.clear.cgColor
            userNameTextField.layer.borderWidth = 0.0
        }
        
        if passwordTextField.text?.isEmpty ?? true {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 1.0
        } else {
            passwordTextField.layer.borderColor = UIColor.clear.cgColor
            passwordTextField.layer.borderWidth = 0.0
        }
        
                
        // Text field'ların hepsi doluysa kullanıcı kaydediliyor.
        if !(userNameTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true)     {
            
            let result = authenticateUser(username: userNameTextField.text!, password: passwordTextField.text!)
            if(result){
                let contrller = storyboard?.instantiateViewController(withIdentifier: "ChooseNC") as! UINavigationController
                contrller.modalPresentationStyle = .fullScreen
                contrller.modalTransitionStyle = .coverVertical
                present(contrller, animated: true)
            }else{
                showAlert(with: "The username or password is incorrect. Please try again", title: "Login Failed")
            }
        }
    }
   
    func showAlert(with message: String, title: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    

    
    func authenticateUser(username: String, password: String) -> Bool {
        guard let username = userNameTextField.text, !username.isEmpty else {
            showAlert( with: "Please enter a username", title: "Error")
            return false
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(with: "Please enter a password", title: "Error")
            return false
        }

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "username = %@ AND password = %@", username, password)
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request)
            if result.count == 1 {
                return true
            }
        } catch {
            print("Error authenticating user: \(error.localizedDescription)")
        }
        return false
    }
}
