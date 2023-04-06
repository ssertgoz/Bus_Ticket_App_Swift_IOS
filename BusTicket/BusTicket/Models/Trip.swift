//
//  Trip.swift
//  BusTicket
//
//  Created by serdar on 6.04.2023.
//

import Foundation
import UIKit

struct Trip{
    let numberOfSeats : Int = 47
    let tickets : [Ticket] = []
    let time : Time
    let duration : Time
    let destination : String
    let fromWhere : String
    let price : Int
    let image : UIImage
    let company : String
}
