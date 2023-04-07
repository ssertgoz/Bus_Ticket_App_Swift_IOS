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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var seatView: ALBusSeatView!
    var dataManager = SeatDataManager()

    func setup(_ ticket:Trip){
        imageView.image = ticket.image
        timeLabel.text = "\(String(ticket.time.hour)):\(String(ticket.time.minute))"
        durationLabel.text = "\(String(ticket.duration.hour))h \(String(ticket.duration.minute))m"
        priceLabel.text = "\(String(ticket.price))$"
        
        
        seatView.config.busFrontImage = UIImage(named: "iconBusFront")!
        seatView.config.seatSoldManBGColor = UIColor(95, 183, 238)
        
        seatView.config.seatSoldWomanBGColor = UIColor(243, 134, 212)
        seatView.config.busFrontImageWidth = 100
        
        
        seatView.delegate = dataManager
        seatView.dataSource = dataManager
        
        let mock = MockSeatCreater()
        let first = mock.create(count: 47)
        dataManager.seatList = [first]
        seatView?.reload()
    }
//    override func prepareForReuse() {
//            super.prepareForReuse()
//            stackView.isHidden = true
//        }
    
}
