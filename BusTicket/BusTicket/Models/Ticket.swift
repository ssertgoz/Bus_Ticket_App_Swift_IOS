//
//  Ticket.swift
//  BusTicket
//
//  Created by serdar on 5.04.2023.
//

import Foundation
import UIKit

struct Ticket{
    let passenger : Passenger?
    let date : Date
    let time : Time
    let seats : [Int]?
    let numberOfSeats : Int = 0
    let destination : String
    let fromWhere : String
    let price : Float
    let duration : Time
    let image : UIImage
    
    func compareTickets(tiket : Ticket) -> Bool{
        return true
    }
    
    func getSeatsAsString() -> String{
        return self.seats!.map{ String($0) }.joined(separator: ", ")
    }
}
