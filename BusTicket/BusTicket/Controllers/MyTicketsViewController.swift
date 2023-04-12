//
//  MyTicketsViewController.swift
//  BusTicket
//
//  Created by serdar on 9.04.2023.
//

import UIKit
import CoreData
import Lottie

class MyTicketsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var tickets : [TicketDataBase] = []
    let animationView = LottieAnimationView(name: "empty")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tickets = getTickets()
        setAnimation()
    }
    override func viewWillAppear(_ animated: Bool) {
        tickets = getTickets()
        collectionView.reloadData()
        showEmptyAnimation()
    }
    
    func setAnimation(){
        animationView.isHidden = false

        // Animasyon boyutunu ayarla ve konumlandır
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = view.center

        animationView.loopMode = .loop
        
        // Animasyonu ekranda göster
        view.addSubview(animationView)
        animationView.play()
        showEmptyAnimation()
        // Do any additional setup after loading the view.
    }
    
    func getTickets() -> [TicketDataBase] {
        var tickets: [TicketDataBase] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return tickets
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tickets")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                let seatNumbers = data.value(forKey: "seatNumbers") as! String
                let userId = data.value(forKey: "userId") as! String
                let date = data.value(forKey: "date") as! String
                let time = data.value(forKey: "time") as! String
                let totalPrice = data.value(forKey: "totalPrice") as! String
                let fromCity = data.value(forKey: "fromCity") as! String
                let toCity = data.value(forKey: "toCity") as! String
                let companyImage = data.value(forKey: "companyImage") as! String
                let name = data.value(forKey: "name") as! String
                let ticket = TicketDataBase(name: name, seatNumbers: seatNumbers, userId: userId, date: date, time: time, totalPrice: totalPrice, fromCity: fromCity, toCity: toCity, companyImage: companyImage)
                tickets.append(ticket)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return tickets
    }
    
    func showEmptyAnimation() {
        // Başarılı animasyonu yükle
        if(tickets.isEmpty){
            animationView.isHidden = false
        }
        else{
            animationView.isHidden = true
        }
        
    }

    @IBAction func onDeleteButtonClicked(_ sender: UIButton) {
        showDeleteAlert(forIndex: sender.tag)
    }
    
    
    func showDeleteAlert(forIndex index: Int) {
        let alertController = UIAlertController(title: "Delete Ticket", message: "Are you sure you want to delete this ticket?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            // Deletion process will be performed here
            self.deleteTicket(at: index)
            self.tickets = self.getTickets()
            self.collectionView.reloadData()
            self.showEmptyAnimation()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        if let deleteButton = alertController.actions.first(where: { $0.title == "Delete" }) {
            deleteButton.setValue(UIColor.red, forKey: "titleTextColor")
        }
        
        present(alertController, animated: true, completion: nil)
    }

    func deleteTicket(at index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tickets")
        fetchRequest.includesPropertyValues = false
        do {
            let tickets = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            managedContext.delete(tickets[index])
            try managedContext.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }

    

}
extension MyTicketsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myTicketCell", for: indexPath) as! MyTicketCollectionViewCell
        
        cell.deleteButton.tag = indexPath.row
        cell.setup( tickets[indexPath.row])
        
        return cell
    }
}
