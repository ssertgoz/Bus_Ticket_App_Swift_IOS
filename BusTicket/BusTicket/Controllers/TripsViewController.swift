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
    
    var fromCity : String?
    var toCity : String?
    var day : Int?
    var month : Int?
    var year : Int?
    
    var isSwapped = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 80, image: CompanyImages.pamukkale.getRoundedImage()!, company: CompanyImages.pamukkale.rawValue),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 120, image: CompanyImages.kamilkoc.getRoundedImage()!, company: CompanyImages.kamilkoc.rawValue),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 230, image: CompanyImages.luksadana.getRoundedImage()!, company: CompanyImages.luksadana.rawValue),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 130, image: CompanyImages.izmir.getRoundedImage()!, company: CompanyImages.izmir.rawValue),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 420, image: CompanyImages.alanyalilar.getRoundedImage()!, company: CompanyImages.alanyalilar.rawValue),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 90, image: CompanyImages.gakdeniz.getRoundedImage()!, company: CompanyImages.gakdeniz.rawValue),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 330, image: CompanyImages.varan.getRoundedImage()!, company: CompanyImages.varan.rawValue),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: toCity!, fromWhere: fromCity!, price: 230, image: CompanyImages.metro.getRoundedImage()!, company: CompanyImages.metro.rawValue)
        ]
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDataReceived(_:)), name: Notification.Name("DataReceived"), object: nil)
        
        
    }
    @objc func onDataReceived(_ notification: Notification) {
    
        if let data = notification.userInfo?["data"] as? [String] {
            totalPrice = data[0]
            selectedSeats = data[1]
        }
        //guard let viewControllerName = notification.userInfo?["viewController"] as? String else { return }
        
        
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
        if identifier == "paymentSegue"{
            if (totalPrice == "" || totalPrice == "0$"){
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let calendar = Calendar.current
        if segue.identifier == "paymentSegue" {
            
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
        let contrller = storyboard?.instantiateViewController(withIdentifier: "ChooseNC") as! UINavigationController
        contrller.modalPresentationStyle = .fullScreen
        contrller.modalTransitionStyle = .coverVertical
        present(contrller, animated: true)
    }
    @IBAction func onRightButtonClicked(_ sender: Any) {
        let contrller = storyboard?.instantiateViewController(withIdentifier: "ChooseNC") as! UINavigationController
        contrller.modalPresentationStyle = .fullScreen
        contrller.modalTransitionStyle = .coverVertical
        present(contrller, animated: true)
    }
    
    @IBAction func onBuyTicketButtonClicked(_ sender: Any) {
        if (totalPrice == "" || totalPrice == "0$"){
            let alert=UIAlertController(title: "Error", message: "You should choose seat", preferredStyle: .alert);
            let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in

            }
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil);

        }
        

    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: {
//                if let cell = collectionView.cellForItem(at: indexPath) {
//                    let newSize = CGSize(width: cell.frame.width, height: cell.frame.height + 20)
//                    cell.frame.size = newSize
//                }
//                collectionView.collectionViewLayout.invalidateLayout()
//            }, completion: nil)
////        // Seçilen hücreyi al
////        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
////
////        // Hücrenin boyutunu değiştir
////        cell.frame.size = CGSize(width: cell.frame.size.width, height: 150)
////
////        // Hücreyi yeniden yükle
////        collectionView.reloadItems(at: [indexPath])
//    }
}

extension TripsViewController: UICollectionViewDelegateFlowLayout , UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tripCell", for: indexPath) as! TripsCollectionViewCell
         cell.setup(trips[indexPath.row])
         
         cell.layer.cornerRadius = 10
         if indexPath == selectedIndexPath {
             totalPrice = ""
             selectedTrip = trips[indexPath.row]
             selectedCompanyImage = selectedTrip?.image
             cell.layer.shadowColor = UIColor.black.cgColor
             cell.layer.shadowOffset = CGSize(width: 0, height: 0)
             cell.layer.shadowOpacity = 0.5
             cell.layer.shadowRadius = 5
             cell.layer.masksToBounds = false
             
             cell.totalPriceLabel.isHidden = false
             cell.seatView.isHidden = false
             cell.numberOfSeatToBuyLabel.isHidden =  false
             cell.continouButton.isHidden = false
             cell.staticTotalPrice.isHidden = false
         } else {
             totalPrice = ""
             cell.totalPriceLabel.isHidden = true
             cell.seatView.isHidden = true
             cell.numberOfSeatToBuyLabel.isHidden =  true
             cell.continouButton.isHidden = true
             cell.staticTotalPrice.isHidden = true
             
             cell.layer.shadowOpacity = 0
             cell.layer.masksToBounds = false
         }
         return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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





