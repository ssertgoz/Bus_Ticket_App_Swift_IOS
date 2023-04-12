//
//  BuyTicketUIViewController.swift
//  BusTicket
//
//  Created by serdar on 8.04.2023.
//

import UIKit
import Lottie
import CoreData


class BuyTicketUIViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var expiringDateTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var toCityLabel: UILabel!
    @IBOutlet weak var fromCityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seatNumbersLabel: UILabel!
    @IBOutlet weak var companyImageView: UIImageView!
    
    
    var seatNumbers : String?
    var userId : String?
    var date : String?
    var time : String?
    var totalPrice : String?
    var fromCity : String?
    var toCity : String?
    var companyImage : UIImage?
    var companyImageName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = ""
        nameTextField.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
        approveButton.layer.cornerRadius = 10
        approveButton.layer.masksToBounds = false
        approveButton.layer.shadowColor = UIColor.black.cgColor
        approveButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        approveButton.layer.shadowOpacity = 0.3
        approveButton.layer.shadowRadius = 10
    }        // Do any additional setup after loading the view.
    override func viewWillAppear(_ animated: Bool) {
        
        seatNumbersLabel.text = seatNumbers
        userIdLabel.text = userId
        dateLabel.text = date
        timeLabel.text = time
        totalPriceLabel.text = String(totalPrice!)
        fromCityLabel.text = fromCity
        toCityLabel.text = toCity
        companyImageView.image = companyImage
        

    }
    @objc func onTextChanged() {
        nameLabel.text = nameTextField.text
    }

    @IBAction func approvePayment(_ sender: Any) {
        let result = checkTextFields()
        if(result){
            saveTicket()
            showSuccessAnimation()
        }
    }
    func showSuccessAnimation() {
        // Başarılı animasyonu yükle
        let animationView = LottieAnimationView(name: "done")
        
        // Animasyon boyutunu ayarla ve konumlandır
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        animationView.backgroundColor = .white
        animationView.layer.cornerRadius = 40
        animationView.layer.shadowColor = UIColor.black.cgColor
        animationView.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationView.layer.shadowOpacity = 0.5
        animationView.layer.shadowRadius = 5
        animationView.layer.masksToBounds = false
        
        // Animasyon tekrar oynamasın
        animationView.loopMode = .playOnce
        
        // Animasyonu ekranda göster
        view.addSubview(animationView)
        animationView.play { isFinished in
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.selectedIndex = 1
        }
        
    }
    func saveTicket() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let ticketEntity = NSEntityDescription.entity(forEntityName: "Tickets", in: managedContext)!
        let ticket = NSManagedObject(entity: ticketEntity, insertInto: managedContext)
        
        ticket.setValue(seatNumbers, forKey: "seatNumbers")
        ticket.setValue(nameLabel.text, forKey: "name")
        ticket.setValue(userId, forKey: "userId")
        ticket.setValue(date, forKey: "date")
        ticket.setValue(time, forKey: "time")
        ticket.setValue(totalPrice, forKey: "totalPrice")
        ticket.setValue(fromCity, forKey: "fromCity")
        ticket.setValue(toCity, forKey: "toCity")
        ticket.setValue(companyImageName, forKey: "companyImage")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func checkTextFields() -> Bool {
        if cvvTextField.text!.isEmpty  {
            cvvTextField.layer.borderColor = UIColor.red.cgColor
            cvvTextField.layer.borderWidth = 1.0
        } else {
            cvvTextField.layer.borderColor = UIColor.clear.cgColor
            cvvTextField.layer.borderWidth = 0.0
        }
        
        if expiringDateTextField.text!.isEmpty {
            expiringDateTextField.layer.borderColor = UIColor.red.cgColor
            expiringDateTextField.layer.borderWidth = 1.0
        } else {
            expiringDateTextField.layer.borderColor = UIColor.clear.cgColor
            expiringDateTextField.layer.borderWidth = 0.0
        }
        
        if cardNumberTextField.text!.isEmpty {
            cardNumberTextField.layer.borderColor = UIColor.red.cgColor
            cardNumberTextField.layer.borderWidth = 1.0
        } else {
            cardNumberTextField.layer.borderColor = UIColor.clear.cgColor
            cardNumberTextField.layer.borderWidth = 0.0
        }
        
        if emailTextField.text!.isEmpty  {
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1.0
        } else {
            emailTextField.layer.borderColor = UIColor.clear.cgColor
            emailTextField.layer.borderWidth = 0.0
        }
        
        if nameTextField.text!.isEmpty {
            nameTextField.layer.borderColor = UIColor.red.cgColor
            nameTextField.layer.borderWidth = 1.0
        } else {
            nameTextField.layer.borderColor = UIColor.clear.cgColor
            nameTextField.layer.borderWidth = 0.0
        }
        
        if(cvvTextField.text!.isEmpty || expiringDateTextField.text!.isEmpty ||  cardNumberTextField.text!.isEmpty ||  emailTextField.text!.isEmpty ||  nameTextField.text!.isEmpty ){
            return false
        }


        return true
    }
}
