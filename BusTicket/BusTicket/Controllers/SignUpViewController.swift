//
//  SignUpViewController.swift
//  BusTicket
//
//  Created by serdar on 9.04.2023.
//

import UIKit
import CoreData
import Lottie

class SignUpViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAgainTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        signupButton.layer.cornerRadius = 10
        signupButton.layer.masksToBounds = true
        
        passwordAgainTextField.addTarget(self, action: #selector(comparePasswords), for: .editingChanged)
        
        signupButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
    }
    
    @objc func comparePasswords() {
       if passwordTextField.text != passwordAgainTextField.text {
           // Passwordlar eşleşmiyor, passwordAgainTextField'ın kenarını kırmızı yap.
           passwordAgainTextField.layer.borderColor = UIColor.red.cgColor
           passwordAgainTextField.layer.borderWidth = 1.0
       } else {
           // Passwordlar eşleşiyor, passwordTextField ve passwordAgainTextField'ın kenarını yeşil yap.
           passwordAgainTextField.layer.borderColor = UIColor.green.cgColor
           passwordAgainTextField.layer.borderWidth = 1.0
           passwordTextField.layer.borderColor = UIColor.green.cgColor
           passwordTextField.layer.borderWidth = 1.0
       }
    }
       
    @objc func registerUser() {
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
       
       if passwordAgainTextField.text?.isEmpty ?? true {
           passwordAgainTextField.layer.borderColor = UIColor.red.cgColor
           passwordAgainTextField.layer.borderWidth = 1.0
       } else {
           passwordAgainTextField.layer.borderColor = UIColor.clear.cgColor
           passwordAgainTextField.layer.borderWidth = 0.0
       }
       
       if !(userNameTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true) && !(passwordAgainTextField.text?.isEmpty ?? true) && (passwordTextField.text == passwordAgainTextField.text) && (passwordTextField.text == passwordAgainTextField.text) {
           
           saveUser(username: userNameTextField.text!, password: passwordTextField.text!)
       }
   }
    func showSuccessAnimation() {
        let animationView = LottieAnimationView(name: "done")
        
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        animationView.backgroundColor = .white
        animationView.layer.cornerRadius = 40
        animationView.layer.shadowColor = UIColor.black.cgColor
        animationView.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationView.layer.shadowOpacity = 0.5
        animationView.layer.shadowRadius = 5
        animationView.layer.masksToBounds = false
    
        animationView.loopMode = .playOnce
        
        view.addSubview(animationView)
        animationView.play { isFinished in
            self.navigationController?.popViewController(animated: true)
        }
    }

    
    func showAlert(with message: String, isError: Bool) {
        let alert = UIAlertController(title: isError ? "Error" : "Success",message: message,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func saveUser(username: String, password: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext) else { return  }

        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(username, forKeyPath: "username")
        user.setValue(password, forKeyPath: "password")

        do {
            try managedContext.save()
            showSuccessAnimation()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
