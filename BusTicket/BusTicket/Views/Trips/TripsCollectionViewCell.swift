//
//  TicketsCollectionViewCell.swift
//  BusTicket
//
//  Created by serdar on 6.04.2023.
//

import UIKit

class TripsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: TripsCollectionViewCell.self)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setup(_ ticket:Trip){
        imageView.image = ticket.image
        timeLabel.text = "\(String(ticket.time.hour)):\(String(ticket.time.minute))"
        durationLabel.text = "\(String(ticket.duration.hour))h \(String(ticket.duration.minute))m"
        priceLabel.text = "\(String(ticket.price))$"
    }
    
}
