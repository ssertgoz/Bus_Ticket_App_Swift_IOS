//
//  MyTicketCollectionViewCell.swift
//  BusTicket
//
//  Created by serdar on 9.04.2023.
//

import UIKit

class MyTicketCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var passengerID: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var companyImage: UIImageView!
    
    func setup(_ ticket:TicketDataBase){
        
        nameLabel.text = "\(ticket.name)"
        companyImage.image = UIImage(named: ticket.companyImage)
        fromLabel.text = ticket.fromCity
        toLabel.text = ticket.toCity
        passengerID.text = ticket.userId
        timeLabel.text = ticket.time
        dateLabel.text = ticket.date
        seatsLabel.text = ticket.seatNumbers
    }
}
