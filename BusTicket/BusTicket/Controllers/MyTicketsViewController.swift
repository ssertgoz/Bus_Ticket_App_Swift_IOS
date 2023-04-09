//
//  MyTicketsViewController.swift
//  BusTicket
//
//  Created by serdar on 9.04.2023.
//

import UIKit

class MyTicketsViewController: UIViewController {

    var tickets : [Ticket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tickets.append(Ticket(passenger: Passenger(id: 1, name: "Serdar", surname: "Sertgöz"), date: Date(), time: Time(), seats: [3,40], destination: "Amerika", fromWhere: "İzmir", price: 399, duration: Time(hour: 4,minute: 40), image: CompanyImages.varan.getRoundedImage()!))
        tickets.append(Ticket(passenger: Passenger(id: 1, name: "Serdar", surname: "Sertgöz"), date: Date(), time: Time(), seats: [3,40], destination: "Amerika", fromWhere: "İzmir", price: 399, duration: Time(hour: 4,minute: 40), image: CompanyImages.alanyalilar.getRoundedImage()!))
        tickets.append(Ticket(passenger: Passenger(id: 1, name: "Serdar", surname: "Sertgöz"), date: Date(), time: Time(), seats: [3,40], destination: "Amerika", fromWhere: "İzmir", price: 399, duration: Time(hour: 4,minute: 40), image: CompanyImages.pamukkale.getRoundedImage()!))
        tickets.append(Ticket(passenger: Passenger(id: 1, name: "Serdar", surname: "Sertgöz"), date: Date(), time: Time(), seats: [3,40], destination: "Amerika", fromWhere: "İzmir", price: 399, duration: Time(hour: 4,minute: 40), image: CompanyImages.kamilkoc.getRoundedImage()!))
        // Do any additional setup after loading the view.
    }
    

 

}
extension MyTicketsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("burada")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myTicketCell", for: indexPath) as! MyTicketCollectionViewCell
        
        cell.setup( tickets[indexPath.row])
        
        return cell
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let width = scrollView.frame.width
//
//        currentPage = Int(scrollView.contentOffset.x/(width-50))
//        pageControl.currentPage = currentPage
//    }
    
}
