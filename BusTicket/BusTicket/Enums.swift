//
//  Enums.swift
//  BusTicket
//
//  Created by serdar on 9.04.2023.
//

import Foundation
import UIKit

enum CompanyImages : String{
    case alanyalilar = "alanyalilar-turizm"
    case gakdeniz = "gakdeniz"
    case izmir = "izmir"
    case kamilkoc = "kamilkoc"
    case luksadana = "lüksadana"
    case metro = "metro"
    case pamukkale = "pamukkale"
    case varan = "varan"
    
    
    func getImage() -> UIImage? {
            return UIImage(named: self.rawValue)?.withRenderingMode(.alwaysOriginal)
        }
        
    func getRoundedImage() -> UIImage? {
        let cornerRadius :CGFloat = 60
        if let image = self.getImage() {
            let rect = CGRect(origin: .zero, size: image.size)
            UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            image.draw(in: rect)
            let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return roundedImage?.withRenderingMode(.alwaysOriginal)
        }
        return nil
    }
}

enum SegueIdentifiers : String{
    case goToPaymentPage = "paymentSegue"
    case goToTripsPage = "showSecondViewControllerSegue"
}
