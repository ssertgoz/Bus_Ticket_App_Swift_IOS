//
//  ChooseViewController.swift
//  BusTicket
//
//  Created by serdar on 4.04.2023.
//

import UIKit

class ChooseViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var findTicketsButton: UIButton!
    @IBOutlet weak var datePic: UIDatePicker!
    @IBOutlet weak var toLabelTOChoose: UILabel!
    @IBOutlet weak var fromLabelToChoose: UILabel!
    
    let city1PickerView = UIPickerView()
    let subView = UIView()
    let toolbar = UIToolbar()
    var choosenFromCity : String?
    var choosenToCity : String?
    
    var isFromButtonClicked : Bool = false
    var isOkeyToFindTickets = false
    
    let cities = ["Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Aksaray", "Amasya", "Ankara", "Antalya", "Ardahan", "Artvin", "Aydın", "Balıkesir", "Bartın", "Batman", "Bayburt", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Düzce", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkâri", "Hatay", "Iğdır", "Isparta", "İstanbul", "İzmir", "Kahramanmaraş", "Karabük", "Karaman", "Kars", "Kastamonu", "Kayseri", "Kırıkkale", "Kırklareli", "Kırşehir", "Kilis", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Mardin", "Mersin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Osmaniye", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Şanlıurfa", "Şırnak", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Uşak", "Van", "Yalova", "Yozgat", "Zonguldak"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureView()
    }
    
    
    func configureView(){
        navigationItem.hidesBackButton = true
        datePic.minimumDate = .now
        
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
        
        view.addSubview(subView)
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
                fromLabelToChoose.text = selectedCity
                isFromButtonClicked = false
                self.subView.isHidden = true
                self.city1PickerView.isHidden = true
            }
        }else{
            guard let selectedCity = choosenToCity else { return }
            if(selectedCity == choosenFromCity){
                showAlert(with: "Choose another city", title: "You can not choos same city")
            }else{
                toLabelTOChoose.text = selectedCity
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
        isFromButtonClicked = false
    }
    
    
    @IBAction func onClicked(_ sender: UIButton) {
        
        // İF dışındakini kaldır

        if(choosenToCity == nil || choosenFromCity == nil){
            showAlert(with: "You should choose city", title: "Error")
        }
    }
    
    @IBAction func onDateChanged(_ sender: Any) {

    }
    
    func showAlert(with message: String, title: String) {
        let alert = UIAlertController(title: title,message: message,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let calendar = Calendar.current
        if segue.identifier == SegueIdentifiers.goToTripsPage.rawValue {
            
            if let tabBarController = segue.destination as? TabBarViewController{
                tabBarController.fromCity = choosenFromCity
                tabBarController.toCity = choosenToCity
                tabBarController.day = calendar.component(.day, from: datePic.date)
                tabBarController.month = calendar.component(.month, from: datePic.date)
                tabBarController.year = calendar.component(.year, from: datePic.date)

            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == SegueIdentifiers.goToTripsPage.rawValue {
            if(isOkeyToFindTickets){
                return true
            }
        }
        return false
    }

    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(isFromButtonClicked){
            choosenFromCity = cities[row]
        }else{
            choosenToCity = cities[row]
        }
        
        if(choosenToCity != nil && choosenFromCity != nil){
            isOkeyToFindTickets = true
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

