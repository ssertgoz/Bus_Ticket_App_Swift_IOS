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
    @IBOutlet weak var companyImage: UIImageView!
    
    func setup(_ ticket:Ticket){
        nameLabel.text = "\(ticket.passenger!.name) \(ticket.passenger!.surname)"
        companyImage.image = ticket.image
        fromLabel.text = ticket.fromWhere
        toLabel.text = ticket.destination
        passengerID.text = "\(String(describing: ticket.passenger?.id))"
        timeLabel.text = ticket.time.getTime()
        dateLabel.text = ticket.date.getDate()
        seatsLabel.text = ticket.getSeatsAsString()
    }
}
