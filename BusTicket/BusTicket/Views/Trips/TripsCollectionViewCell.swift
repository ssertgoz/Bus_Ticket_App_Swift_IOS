//
//  TicketsCollectionViewCell.swift
//  BusTicket
//
//  Created by serdar on 6.04.2023.
//

import UIKit
import ALBusSeatView

class TripsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: TripsCollectionViewCell.self)
    
    @IBOutlet weak var continouButton: UIButton!
    @IBOutlet weak var staticTotalPrice: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var seatView: ALBusSeatView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var numberOfSeatToBuyLabel: UILabel!
    var seatList = [[SeatStub]]()
    var selectedSeatlist = [SeatStub]()
    var price = 0

    func setup(_ ticket:Trip){
        price = ticket.price
        continouButton.layer.cornerRadius = 10
        continouButton.layer.masksToBounds = true
        imageView.image = ticket.image
        totalPriceLabel.text = "\(String(selectedSeatlist.count*price))$"
        numberOfSeatToBuyLabel.text = "\(String(selectedSeatlist.count))X\(String(price))"
        timeLabel.text = "\(String(ticket.time.hour)):\(String(ticket.time.minute))"
        durationLabel.text = "\(String(ticket.duration.hour))h \(String(ticket.duration.minute))m"
        priceLabel.text = "\(String(ticket.price))$"
        
        
        seatView.config.busFrontImage = UIImage(named: "iconBusFront")!
        seatView.config.seatSoldManBGColor = UIColor(31, 205, 251)
        seatView.config.seatSelectedBGColor = UIColor(113, 220, 96)
        seatView.config.seatSoldWomanBGColor = UIColor(243, 134, 212)
        seatView.config.busFrontImageWidth = 100
        
        
        
        seatView.delegate = self
        seatView.dataSource = self
        
        
        let mock = MockSeatCreater()
        let first = mock.create(count: 47)
        seatList = [first]
        seatView?.reload()
    }
    
    

    //    override func prepareForReuse() {
//            super.prepareForReuse()
//            stackView.isHidden = true
//        }
}



extension TripsCollectionViewCell: ALBusSeatViewDelegate{
        
    // I used these functions since I got errors about showing alert dialog
        class func topMostController() -> UIViewController {
            var topController: UIViewController?
            if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
               let mainWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
                topController = mainWindow.rootViewController
            }
            
            while ((topController?.presentedViewController) != nil) {
                topController = topController?.presentedViewController
            }
            return topController!
        }

        class func alert(message:String){
            let alert=UIAlertController(title: "Error", message: message, preferredStyle: .alert);
            let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in

            }
            alert.addAction(cancelAction)
            TripsCollectionViewCell.topMostController().present(alert, animated: true, completion: nil);
        }
    
    func seatView(_ seatView: ALBusSeatView,
                  didSelectAtIndex indexPath: IndexPath,
                  seatType: ALBusSeatType, selectionType: ALSelectionType) {
    
        
        
        if(self.selectedSeatlist.count == 5){
            TripsCollectionViewCell.alert(message:"You can not reserve more than 5 seats")
            
        }else{
            
            var stub = seatList[indexPath.section][indexPath.item]
            stub.gender = selectionType == .man ? true : false
            self.selectedSeatlist.append(stub)
            totalPriceLabel.text = "\(String(selectedSeatlist.count*price))$"
            numberOfSeatToBuyLabel.text = "\(String(selectedSeatlist.count))X\(String(price))"
            let dataToSend = ["\(String(selectedSeatlist.count*price))$",selectedSeatlist.map{String(($0).number)}.joined(separator: ", ")]
            let userInfo = ["data": dataToSend]
            NotificationCenter.default.post(name: Notification.Name("DataReceived"), object: nil, userInfo: userInfo)
            seatView.reload()
        }
        
    }
    
    func seatView(_ seatView: ALBusSeatView,
                  deSelectAtIndex indexPath: IndexPath,
                  seatType: ALBusSeatType) {
        
        let stub = seatList[indexPath.section][indexPath.item]
        self.selectedSeatlist.removeAll(where: { $0.id == stub.id })
        totalPriceLabel.text = "\(String(selectedSeatlist.count*price))$"
        numberOfSeatToBuyLabel.text = "\(String(selectedSeatlist.count))X\(String(price))"
        let dataToSend = ["\(String(selectedSeatlist.count*price))$",selectedSeatlist.map{String(($0).number)}.joined(separator: ", ")]
        let userInfo = ["data": dataToSend]
        NotificationCenter.default.post(name: Notification.Name("DataReceived"), object: nil, userInfo: userInfo)
        seatView.reload()
    }
}

extension TripsCollectionViewCell:  ALBusSeatViewDataSource  {
    
    func seatView(_ seatView: ALBusSeatView,
                  seatNumberForIndex indexPath: IndexPath) -> String {
        
        let stub = seatList[indexPath.section][indexPath.item]
        return "\(stub.number)"
    }
    
    func seatView(_ seatView: ALBusSeatView,
                  seatTypeForIndex indexPath: IndexPath) -> ALBusSeatType {
        
        let stub = seatList[indexPath.section][indexPath.item]
        
        if stub.hall { // Hall area
            return .none
        } else if selectedSeatlist.contains(where: { $0.id == stub.id }) { // Selected
            return .selected
        } else if stub.salable { // Open for sale
            return .empty
        } else if stub.gender == true { // Full by man
            return .soldMan
        } else if stub.gender == false { // Full by woman
            return .soldWoman
        } else { // Else not a seat
            return .none
        }
    }
    
    func numberOfSections(in seatView: ALBusSeatView) -> Int {
        return seatList.count
    }
    
    func seatView(_ seatView: ALBusSeatView,
                  numberOfSeatInSection section: Int) -> Int {
        
        return seatList[section].count
    }
}
