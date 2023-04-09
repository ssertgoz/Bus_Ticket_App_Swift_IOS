//
//  OnboardingViewController.swift
//  BusTicket
//
//  Created by serdar on 2.04.2023.
//

import UIKit
import Lottie

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var currentPage = 0 {
        didSet{
            if currentPage == (slides.count - 1){
                nextButton.setTitle("Get Started", for: .normal)
            }else{
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    var slides : [OnboardingSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        let image1 = UIImage(named: "slidePic1")!
        let image2 = UIImage(named: "slidePic2")!
        let image3 = UIImage(named: "slidePic3")!
        slides = [
            OnboardingSlide(title: "Welcome to our Bus Ticket Booking App", descripton: "Book your bus tickets in just a few clicks and travel hassle-free.", image: image1,animationName: "lotti1"),
            OnboardingSlide(title: "Environmentally Friendly Ticketing", descripton: "Our ticketing system is designed to reduce paper waste and minimize our carbon footprint. ", image:  image2,animationName: "lotti2"),
            OnboardingSlide(title: "Customer Service at Its Finest", descripton: "At SwiftPass, we believe that exceptional customer service is the key to a great experience. Our dedicated team is available 24/7 to answer any questions", image:  image3,animationName: "lotti3")

        ]
        
        pageControl.numberOfPages = slides.count
    }

    private func configureCollectionView() {
        nextButton.layer.cornerRadius = 10
        nextButton.layer.masksToBounds = true

        // Instead this, you can specify from main by going to connection inspector
//        collectionView.delegate = self
//        collectionView.dataSource = self
    }
    @IBAction func skipButtonClicked(_ sender: Any) {
        let contrller = storyboard?.instantiateViewController(withIdentifier: "LoginNC") as! UINavigationController
        contrller.modalPresentationStyle = .fullScreen
        contrller.modalTransitionStyle = .flipHorizontal
        present(contrller, animated: true)
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if(currentPage == slides.count-1){
            let contrller = storyboard?.instantiateViewController(withIdentifier: "LoginNC") as! UINavigationController
            contrller.modalPresentationStyle = .fullScreen
            contrller.modalTransitionStyle = .flipHorizontal
            present(contrller, animated: true)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentPage
        }
        
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup( slides[indexPath.row])
        
        return cell
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let width = scrollView.frame.width
//
//        currentPage = Int(scrollView.contentOffset.x/(width-50))
//        pageControl.currentPage = currentPage
//    }
    
}

