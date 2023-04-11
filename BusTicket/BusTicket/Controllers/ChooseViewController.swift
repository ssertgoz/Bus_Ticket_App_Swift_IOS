//
//  ChooseViewController.swift
//  BusTicket
//
//  Created by serdar on 4.04.2023.
//

import UIKit
import iOSDropDown

class ChooseViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var findTicketsButton: UIButton!
    @IBOutlet weak var datePic: UIDatePicker!
    
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    
    let city1PickerView = UIPickerView()
    let subView = UIView()
    let toolbar = UIToolbar()
    var choosenFromCity : String?
    var choosenToCity : String?
    
    var isFromButtonClicked : Bool = false
    
    let cities = ["Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Aksaray", "Amasya", "Ankara", "Antalya", "Ardahan", "Artvin", "Aydın", "Balıkesir", "Bartın", "Batman", "Bayburt", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Düzce", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkâri", "Hatay", "Iğdır", "Isparta", "İstanbul", "İzmir", "Kahramanmaraş", "Karabük", "Karaman", "Kars", "Kastamonu", "Kayseri", "Kırıkkale", "Kırklareli", "Kırşehir", "Kilis", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Mardin", "Mersin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Osmaniye", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Şanlıurfa", "Şırnak", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Uşak", "Van", "Yalova", "Yozgat", "Zonguldak"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(onDataReceived(_:)), name: Notification.Name("DataReceived"), object: nil)
        datePic.minimumDate = .now
        configureDropDowns()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func onDataReceived(_ notification: Notification) {
        if let data = notification.userInfo?["data"] as? String {
            print("Received data: \(data)")
        }
        //guard let viewControllerName = notification.userInfo?["viewController"] as? String else { return }
        
        
    }
    
    @objc func viewControllerChanged(notification: NSNotification) {
          guard let viewControllerName = notification.userInfo?["viewController"] as? String else { return }
          
          if viewControllerName == "FirstViewController" {
              print("FirstViewController'e geçildi")
          }
      }
    
    
    
    func configureDropDowns(){
        fromLabel.layer.cornerRadius = fromLabel.frame.height / 4
        fromLabel.layer.masksToBounds = true
        toLabel.layer.cornerRadius = toLabel.frame.height / 4
        toLabel.layer.masksToBounds = true
        dateLabel.layer.cornerRadius = dateLabel.frame.height / 4
        dateLabel.layer.masksToBounds = true
        findTicketsButton.layer.cornerRadius = 10
        findTicketsButton.layer.masksToBounds = true
        
        toolbar.sizeToFit()
        toolbar.barStyle = .default
        toolbar.backgroundColor = .white
        city1PickerView.backgroundColor =  .white
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        subView.translatesAutoresizingMaskIntoConstraints = false
        city1PickerView.translatesAutoresizingMaskIntoConstraints = false

        city1PickerView.delegate = self
        city1PickerView.dataSource = self
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)

        view.addSubview(subView)
        view.addSubview(visualEffectView)
        subView.addSubview(toolbar)
        view.addSubview(city1PickerView)
        
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            subView.heightAnchor.constraint(equalToConstant: 250),
            subView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            
            
            city1PickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            city1PickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            city1PickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            city1PickerView.heightAnchor.constraint(equalToConstant: 200),
            city1PickerView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            
            
            toolbar.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: subView.trailingAnchor),
            toolbar.topAnchor.constraint(equalTo: subView.topAnchor,constant: 0),
            toolbar.heightAnchor.constraint(equalToConstant: 50),

        ])
        self.subView.isHidden = true
        self.city1PickerView.isHidden = true

    }
    
    
    
    @objc func doneButtonTapped() {
        
        if(isFromButtonClicked){
            guard let selectedCity = choosenFromCity else { return }
            if(selectedCity == choosenToCity){
                showAlert(with: "Choose another city", title: "You can not choos same city")
            }else{
                fromButton.titleLabel?.text = selectedCity
                isFromButtonClicked = false
                self.subView.isHidden = true
                self.city1PickerView.isHidden = true
            }
        }else{
            guard let selectedCity = choosenToCity else { return }
            if(selectedCity == choosenFromCity){
                showAlert(with: "Choose another city", title: "You can not choos same city")
            }else{
                toButton.titleLabel?.text = selectedCity
                isFromButtonClicked = false
                self.subView.isHidden = true
                self.city1PickerView.isHidden = true
            }
            
        }
        
    }
    
    @IBAction func fromButtonClicked(_ sender: Any) {
        self.subView.isHidden = false
        self.city1PickerView.isHidden = false
        isFromButtonClicked = true

        
    }
    @IBAction func toButtonClicked(_ sender: Any) {
        self.subView.isHidden = false
        self.city1PickerView.isHidden = false
    }
    
    
    @IBAction func onClicked(_ sender: UIButton) {
        // İF dışındakini kaldır
        let contrller = storyboard?.instantiateViewController(withIdentifier: "TabbarNC") as! UITabBarController
        contrller.modalPresentationStyle = .fullScreen
        let dataToSend = "Hello, world!"
        let userInfo = ["data": dataToSend]
        NotificationCenter.default.post(name: Notification.Name("DataReceived"), object: nil, userInfo: userInfo)
        present(contrller, animated: true)
//        if(choosenToCity != nil && choosenFromCity != nil){
//            let contrller = storyboard?.instantiateViewController(withIdentifier: "TabbarNC") as! UITabBarController
//            contrller.modalPresentationStyle = .fullScreen
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ViewControllerChanged"), object: nil, userInfo: ["viewController": "TripsViewController"])
//            present(contrller, animated: true)
//
//        }
    }
    
    @IBAction func onDateChanged(_ sender: Any) {
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: datePic.date)
        let month = calendar.component(.month, from: datePic.date)
        let year = calendar.component(.year, from: datePic.date)
        print("\(day) - \(month) - \(year)")
    }
    
    func showAlert(with message: String, title: String) {
        let alert = UIAlertController(title: title,message: message,preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondViewControllerSegue" {
            if let navController = segue.destination as? UINavigationController, let secondViewController = navController.topViewController as? SecondViewController {
                tripsViewController.fromCity = choosenFromCity
                tripsViewController.toCity = choosenToCity
                tripsViewController.day = calendar.component(.day, from: datePic.date)
                tripsViewController.month = calendar.component(.month, from: datePic.date)
                tripsViewController.year = calendar.component(.year, from: datePic.date)

            }
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(isFromButtonClicked){
            choosenFromCity = cities[row]
        }else{
            choosenToCity = cities[row]
        }
    }
    // Number of columns in each picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows in each picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    // Title for each row in each picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
}

