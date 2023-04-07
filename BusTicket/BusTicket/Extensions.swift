//
//  Extensions.swift
//  BusTicket
//
//  Created by serdar on 8.04.2023.
//

import Foundation
import UIKit

extension UIColor {
   convenience init(_ red: Int, _ green: Int, _ blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
            (rgb >> 16) & 0xFF,
            (rgb >> 8) & 0xFF,
           rgb & 0xFF
       )
   }
}
