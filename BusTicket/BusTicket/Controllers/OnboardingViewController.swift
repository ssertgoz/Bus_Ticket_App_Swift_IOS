//
//  OnboardingViewController.swift
//  BusTicket
//
//  Created by serdar on 2.04.2023.
//

import UIKit
import Lottie

// Define a view controller for the onboarding screen that inherits from UIViewController.
class OnboardingViewController: UIViewController {

    // Connect the collection view, page control, and next button to the storyboard.
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    // An array of onboarding slides to be displayed.
    var slides: [OnboardingSlide] = []
    
    // Keep track of the current page index and update the next button's title accordingly.
    var currentPage = 0 {
        didSet{
            if currentPage == (slides.count - 1){
                nextButton.setTitle("Get Started", for: .normal)
            } else{
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    // This method is called after the view has been loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the collection view.
        configureCollectionView()
    }

    // Configure the collection view's UI and settings.
    private func configureCollectionView() {
        // Round the corners of the next button.
        nextButton.layer.cornerRadius = 10
        nextButton.layer.masksToBounds = true
        // Set the number of pages on the page control to match the number of onboarding slides.
        pageControl.numberOfPages = slides.count
        // Define the onboarding slides with titles, descriptions, and animation names.
        slides = [
            OnboardingSlide(title: "Welcome to our Bus Ticket Booking App", descripton: "Book your bus tickets in just a few clicks and travel hassle-free.", animationName: "lotti1"),
            OnboardingSlide(title: "Environmentally Friendly Ticketing", descripton: "Our ticketing system is designed to reduce paper waste and minimize our carbon footprint. ", animationName: "lotti2"),
            OnboardingSlide(title: "Customer Service at Its Finest", descripton: "At SwiftPass, we believe that exceptional customer service is the key to a great experience. Our dedicated team is available 24/7 to answer any questions", animationName: "lotti3")]
    }
    
    // This method is called when the user clicks the skip button or get started button.
    func goToLogin() {
        // Instantiate a navigation controller for the login screen.
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginNC") as! UINavigationController
        // Set the presentation style and transition style for the navigation controller.
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        // Present the navigation controller.
        present(controller, animated: true)
    }
    
    // This method is called when the user clicks the skip button.
    @IBAction func skipButtonClicked(_ sender: Any) {
        // Go to the login screen.
        goToLogin()
    }
    
    // This method is called when the user clicks the next button.
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        // If the current page is the last page, go to the login screen.
        if(currentPage == slides.count-1){
            goToLogin()
        } else {
            // If the current page is not the last page, increment the current page index and scroll to the next page.
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentPage
        }
    }
}



extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // This function specifies the number of items in the collection view section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }

    // This function dequeues and configures cells to be displayed in the collection view.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue a reusable cell using the "myCell" identifier and cast it as an OnboardingCollectionViewCell.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! OnboardingCollectionViewCell
        
        // Configure the cell using the slide at the current index path.
        cell.setup( slides[indexPath.row])
        
        return cell
    }
}

