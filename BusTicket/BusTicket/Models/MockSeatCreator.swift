//
//  MockSeatCreator.swift
//  BusTicket
//
//  Created by serdar on 7.04.2023.
//

import Foundation

struct SeatStub {
    let id: String
    let number: Int
    let salable: Bool
    var gender: Bool
    let hall: Bool
}

class MockSeatCreater {
    
    func create(count: Int) -> [SeatStub] {
        var list = [SeatStub]()
        var numCount : Int = 0
        let numberOfHall = calculateSeatCount(count)
        
        (1...(numberOfHall+1)).forEach { (count) in
            let isHall = (count - 2) % 5 == 1
            if isHall {numCount -= 1}
            numCount += 1
            let stub = SeatStub(id: UUID().uuidString,
                                number: numCount,
                                salable: Bool.random(),
                                gender: Bool.random(),
                                hall: isHall)
            list.append(stub)
        }
        return list
    }
    private func calculateSeatCount(_ totalSeatCount: Int) -> Int {
        let a = Int(totalSeatCount/2)
        let b = totalSeatCount - a
        var c = 0
        if a <= b{
            c = Int(ceil(Double(a/2))) + totalSeatCount
        }
        return c
    }
}
