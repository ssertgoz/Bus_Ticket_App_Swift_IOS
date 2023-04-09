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
    
    var collectionView2 : UICollectionView!
    
    var trips : [Trip] = []
    var totalPrice = 0
    var selectedIndexPath: IndexPath?
    var alertController : UIAlertController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //collectionView.delegate = self
//        collectionView.dataSource = self

        trips = [
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: CompanyImages.alanyalilar.getRoundedImage()!, company: "Pamukkale"),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: CompanyImages.pamukkale.getRoundedImage()!, company: "Pamukkale"),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: CompanyImages.kamilkoc.getRoundedImage()!, company: "Pamukkale"),Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: CompanyImages.luksadana.getRoundedImage()!, company: "Pamukkale"),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: CompanyImages.izmir.getRoundedImage()!, company: "Pamukkale"),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: CompanyImages.alanyalilar.getRoundedImage()!, company: "Pamukkale"),Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: CompanyImages.gakdeniz.getRoundedImage()!, company: "Pamukkale"),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: CompanyImages.varan.getRoundedImage()!, company: "Pamukkale"),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: CompanyImages.metro.getRoundedImage()!, company: "Pamukkale")
        ]
       
        
    }

    @IBAction func onBuyTicketButtonClicked(_ sender: Any) {
        print("test")
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
             cell.layer.shadowColor = UIColor.black.cgColor
             cell.layer.shadowOffset = CGSize(width: 0, height: 0)
             cell.layer.shadowOpacity = 0.5
             cell.layer.shadowRadius = 5
             cell.layer.masksToBounds = false
             cell.seatView.isHidden = false
         } else {
             cell.seatView.isHidden = true
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





