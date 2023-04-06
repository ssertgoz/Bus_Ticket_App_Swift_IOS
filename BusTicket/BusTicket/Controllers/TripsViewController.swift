//
//  TicketsViewController.swift
//  BusTicket
//
//  Created by serdar on 3.04.2023.
//

import UIKit

class TripsViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    
    var trips : [Trip] = [] 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let image1 = UIImage(named: "slidePic1")!
        let image2 = UIImage(named: "slidePic2")!
        let image3 = UIImage(named: "slidePic3")!
        trips = [
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: image1, company: "Pamukkale"),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: image2, company: "Pamukkale"),
            Trip(time: Time(hour : 1, minute : 30), duration: Time(hour : 1, minute : 30), destination: "Amerika", fromWhere: "İzmir", price: 50, image: image3, company: "Pamukkale")
        ]
        
        
    }
    


}
extension TripsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(trips.count)
    
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("burada")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tripsCell", for: indexPath) as! TripsCollectionViewCell
        
        
        cell.setup( trips[indexPath.row])
        
        return cell
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let width = scrollView.frame.width
//
//        currentPage = Int(scrollView.contentOffset.x/(width-50))
//        pageControl.currentPage = currentPage
//    }
    
}
