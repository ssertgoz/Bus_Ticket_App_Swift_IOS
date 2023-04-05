//
//  ChooseViewController.swift
//  BusTicket
//
//  Created by serdar on 4.04.2023.
//

import UIKit
import iOSDropDown

class ChooseViewController: UIViewController {
    
    @IBOutlet weak var findTicketsButton: UIButton!

    @IBOutlet weak var datePic: UIDatePicker!
    
    @IBOutlet weak var fromDropDown: DropDown!
    
    @IBOutlet weak var toDropDown: DropDown!
    
    var choosenFromCity : String?
    var choosenToCity : String?
    
    let cities = ["Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Aksaray", "Amasya", "Ankara", "Antalya", "Ardahan", "Artvin", "Aydın", "Balıkesir", "Bartın", "Batman", "Bayburt", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Düzce", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkâri", "Hatay", "Iğdır", "Isparta", "İstanbul", "İzmir", "Kahramanmaraş", "Karabük", "Karaman", "Kars", "Kastamonu", "Kayseri", "Kırıkkale", "Kırklareli", "Kırşehir", "Kilis", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Mardin", "Mersin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Osmaniye", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Şanlıurfa", "Şırnak", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Uşak", "Van", "Yalova", "Yozgat", "Zonguldak"]


    override func viewDidLoad() {
        super.viewDidLoad()
        datePic.minimumDate = .now
        configureDropDowns()
        

        // Do any additional setup after loading the view.
    }
    
    func configureDropDowns(){
        
        fromDropDown.optionArray = cities
        fromDropDown.layer.shadowColor = .none
        toDropDown.optionArray = cities
        fromDropDown.didSelect{(selectedText , index ,id) in
            self.choosenFromCity = selectedText
            }
        toDropDown.didSelect{(selectedText , index ,id) in
        self.choosenToCity = selectedText
            }
    }
    
    @IBAction func onClicked(_ sender: UIButton) {
        if(choosenToCity != nil && choosenFromCity != nil){
            print("Geldi")
            let contrller = storyboard?.instantiateViewController(withIdentifier: "TabbarNC") as! UITabBarController
            contrller.modalPresentationStyle = .fullScreen
            
            present(contrller, animated: true)
        }
    }
    
    @IBAction func onDateChanged(_ sender: Any) {
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: datePic.date)
        let month = calendar.component(.month, from: datePic.date)
        let year = calendar.component(.year, from: datePic.date)
        print("\(day) - \(month) - \(year)")
    }
    
}
