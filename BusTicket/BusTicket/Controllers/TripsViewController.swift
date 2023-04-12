//
//  TicketsViewController.swift
//  BusTicket
//
//  Created by serdar on 3.04.2023.
//

import UIKit
import ALBusSeatView

class TripsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    
    var trips : [Trip] = []
    var totalPrice = ""
    var selectedIndexPath: IndexPath?
    var selectedTrip : Trip?
    var selectedSeats : String?
    var selectedCompanyImage : UIImage?
    var alertController : UIAlertController?
    
    // For Segue
    var fromCity : String?
    var toCity : String?
    var day : Int?
    var month : Int?
    var year : Int?
    
    // To check cities are swapped
    var isSwapped = false
    
    let layout = UICollectionViewFlowLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.collectionViewLayout = layout
        configureView()
        NotificationCenter.default.addObserver(self, selector: #selector(onDataReceived(_:)), name: Notification.Name("DataReceived"), object: nil)
    }
    
    func configureView(){
        rightButton.layer.cornerRadius = 10
        rightButton.layer.masksToBounds = true
        middleButton.layer.cornerRadius = 10
        middleButton.layer.masksToBounds = true
        leftButton.layer.cornerRadius = 10
        leftButton.layer.masksToBounds = true
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        let date = calendar.date(from: dateComponents)
        datePicker.setDate(date!, animated: true)

        trips = [
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 500, image: CompanyImages.alanyalilar.getRoundedImage()!, company: CompanyImages.alanyalilar.rawValue),
            Trip(time: Time(hour : 13, minute : 30), duration: Time(hour : 3, minute : 45), destination: toCity!, fromWhere: fromCity!, price: 80, image: CompanyImages.pamukkale.getRoundedImage()!, company: CompanyImages.pamukkale.rawValue),
            Trip(time: Time(hour : 10, minute : 30), duration: Time(hour : 4, minute : 50), destination: toCity!, fromWhere: fromCity!, price: 120, image: CompanyImages.kamilkoc.getRoundedImage()!, company: CompanyImages.kamilkoc.rawValue),
            Trip(time: Time(hour : 4, minute : 20), duration: Time(hour : 5, minute : 20), destination: toCity!, fromWhere: fromCity!, price: 230, image: CompanyImages.luksadana.getRoundedImage()!, company: CompanyImages.luksadana.rawValue),
            Trip(time: Time(hour : 3, minute : 30), duration: Time(hour : 12, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 130, image: CompanyImages.izmir.getRoundedImage()!, company: CompanyImages.izmir.rawValue),
            Trip(time: Time(hour : 6, minute : 30), duration: Time(hour : 14, minute : 40), destination: toCity!, fromWhere: fromCity!, price: 420, image: CompanyImages.alanyalilar.getRoundedImage()!, company: CompanyImages.alanyalilar.rawValue),
            Trip(time: Time(hour : 8, minute : 30), duration: Time(hour : 3, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 90, image: CompanyImages.gakdeniz.getRoundedImage()!, company: CompanyImages.gakdeniz.rawValue),
            Trip(time: Time(hour : 20, minute : 30), duration: Time(hour : 5, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 330, image: CompanyImages.varan.getRoundedImage()!, company: CompanyImages.varan.rawValue),
            Trip(time: Time(hour : 23, minute : 59), duration: Time(hour : 7, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 230, image: CompanyImages.metro.getRoundedImage()!, company: CompanyImages.metro.rawValue)
        ]
        
    }
    
    @objc func onDataReceived(_ notification: Notification) {
    
        if let data = notification.userInfo?["data"] as? [String] {
            totalPrice = data[0]
            selectedSeats = data[1]
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalPrice = ""
        selectedIndexPath = nil
        selectedTrip = nil
        selectedSeats = nil
        selectedCompanyImage = nil
        collectionView.reloadData()
        
        if(!isSwapped){
            rightLabel.text = fromCity
            leftLabel.text = toCity
        }else{
            rightLabel.text = toCity
            leftLabel.text = fromCity
        }
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == SegueIdentifiers.goToPaymentPage.rawValue{
            if (totalPrice == "" || totalPrice == "0$"){
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let calendar = Calendar.current
        if segue.identifier == SegueIdentifiers.goToPaymentPage.rawValue{
            
            if let buyTicketController = segue.destination as? BuyTicketUIViewController{
                buyTicketController.fromCity = rightLabel.text
                buyTicketController.toCity = leftLabel.text
                buyTicketController.date = "\(calendar.component(.day, from: datePicker.date))/\(calendar.component(.month, from: datePicker.date))/\(calendar.component(.year, from: datePicker.date))"
                buyTicketController.time = selectedTrip?.time.getTime()
                buyTicketController.userId = String(123456)
                buyTicketController.totalPrice = totalPrice
                buyTicketController.seatNumbers =  selectedSeats
                buyTicketController.companyImage = selectedCompanyImage
                buyTicketController.companyImageName = selectedTrip?.company

            }
        }
    }
    func goToChooseCities(){
        let contrller = storyboard?.instantiateViewController(withIdentifier: "ChooseNC") as! UINavigationController
        contrller.modalPresentationStyle = .fullScreen
        contrller.modalTransitionStyle = .coverVertical
        present(contrller, animated: true)

    }

    @IBAction func onMiddleButtonClicked(_ sender: Any) {
        if(isSwapped){
            rightLabel.text = fromCity
            leftLabel.text = toCity
        }else{
            rightLabel.text = toCity
            leftLabel.text = fromCity
        }
        isSwapped = !isSwapped
    }
    
    @IBAction func onLeftButtonClicked(_ sender: Any) {
            goToChooseCities()
    }
    
    @IBAction func onRightButtonClicked(_ sender: Any) {
        goToChooseCities()
    }
    
    @IBAction func onBuyTicketButtonClicked(_ sender: Any) {
        if (totalPrice == "" || totalPrice == "0$"){
            let alert=UIAlertController(title: "Error", message: "You should choose seat", preferredStyle: .alert);
            let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in}
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil);
        }
    }
}

extension TripsViewController: UICollectionViewDelegateFlowLayout , UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tripCell", for: indexPath) as! TripsCollectionViewCell
         cell.setup(trips[indexPath.row])
         
         cell.layer.cornerRadius = 10
         cell.layer.masksToBounds = false
         cell.layer.shadowColor = UIColor.black.cgColor
         cell.layer.shadowOffset = CGSize(width: 0, height: 0)
         cell.layer.shadowOpacity = 0.5
         cell.layer.shadowRadius = 5
         totalPrice = ""
         if indexPath == selectedIndexPath {
             selectedTrip = trips[indexPath.row]
             selectedCompanyImage = selectedTrip?.image
             cell.totalPriceLabel.isHidden = false
             cell.seatView.isHidden = false
             cell.numberOfSeatToBuyLabel.isHidden =  false
             cell.continouButton.isHidden = false
             cell.staticTotalPrice.isHidden = false
         } else {
             cell.totalPriceLabel.isHidden = true
             cell.seatView.isHidden = true
             cell.numberOfSeatToBuyLabel.isHidden =  true
             cell.continouButton.isHidden = true
             cell.staticTotalPrice.isHidden = true
         }
         return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Open cell when  they clicked
        if let selectedIndexPath = selectedIndexPath, indexPath == selectedIndexPath {
            return CGSize(width: collectionView.bounds.width - 30, height: 500)
        }
        return CGSize(width: collectionView.bounds.width - 30, height: 130)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath != nil {
            UIView.animate(withDuration: 0, delay: 6, options: .beginFromCurrentState, animations: {
                collectionView.reloadItems(at: [self.selectedIndexPath!])
                        }, completion: nil)
        }
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
            
        } else {
            
            selectedIndexPath = indexPath
        }
       
        collectionView.performBatchUpdates(nil, completion: nil)
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        
        UIView.animate(withDuration: 0, delay: 5, options: .beginFromCurrentState, animations: {
            collectionView.reloadItems(at: [indexPath])
                    }, completion: nil)


    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       

    }
   
}





