//
//  LoginViewController.swift
//  BusTicket
//
//  Created by serdar on 4.04.2023.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    // Outlets for UI elements in the storyboard
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // This function is called after the view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the login button to have rounded corners
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
    }

    // This function is called when the login button is tapped
    @IBAction func loginButton(_ sender: Any) {
        // Attempt to authenticate the user
        let result = authenticateUser(username: userNameTextField.text!, password: passwordTextField.text!)
        if(result){
            // If authentication succeeds, instantiate the ChooseNC navigation controller and present it modally
            let contrller = storyboard?.instantiateViewController(withIdentifier: "ChooseNC") as! UINavigationController
            contrller.modalPresentationStyle = .fullScreen
            contrller.modalTransitionStyle = .coverVertical
            present(contrller, animated: true)
        }else{
            // If authentication fails, show an alert with an error message
            showAlert(with: "The username or password is incorrect. Please try again", title: "Login Failed")
        }
    }

    // This function shows an alert with a given message and title
    func showAlert(with message: String, title: String) {
        let alert = UIAlertController(title: title,message: message,preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }

    // This function attempts to authenticate a user with the given username and password
    func authenticateUser(username: String, password: String) -> Bool {
        // Check that the username and password fields are not empty
        guard let username = userNameTextField.text, !username.isEmpty else {
            showAlert( with: "Please enter a username", title: "Error")
            return false
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(with: "Please enter a password", title: "Error")
            return false
        }

        // Get the app delegate and the view context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let context = appDelegate.persistentContainer.viewContext
        
        // Create a fetch request for the User entity with the given username and password
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "username = %@ AND password = %@", username, password)
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request)
            if result.count == 1 {
                // If there is a match, authentication succeeds
                return true
            }
        } catch {
            print("Error authenticating user: \(error.localizedDescription)")
        }
        // If there is no match, authentication fails
        return false
    }

}
