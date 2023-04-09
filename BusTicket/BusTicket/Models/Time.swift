//
//  Time.swift
//  BusTicket
//
//  Created by serdar on 5.04.2023.
//

import Foundation

struct Time{
    var hour : Int = 0
    var minute : Int = 0
    
    init(hour : Int = 0, minute : Int = 0){
        self.hour = hour
        self.minute = minute
    }
    
    func getTime() -> String{
        return "\(self.hour):\(self.minute)"
    }
}
