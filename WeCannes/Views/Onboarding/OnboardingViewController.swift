//
//  OnboardingViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/22/22.
//

import UIKit
import SwiftyOnboard
import CoreLocation

class OnboardingViewController: UIViewController {
    
    // Variables
    private let permissions = Permissions()
    private var count = 0
    
    var swiftyOnboard: SwiftyOnboard!
    var titleArray: [String] = ["This App Uses Location", "Notifications Enhance Your Experience", "Always Improves Your Experience", "Experience Beacon Magic"]
    var subTitleArray: [String] = ["Confess lets you anonymously\n send confessions to your friends\n and receive confessions from them.", "All confessions sent are\n anonymous. Your friends will only\n know that it came from one of\n their facebook friends.", "Be nice to your friends.\n Send them confessions that\n will make them smile :)", "Because you're awesome"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swiftyOnboard = SwiftyOnboard(frame: view.frame, style: .light)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }
    
    @objc func handleContinue(sender: UIButton) {
//        var index = sender.tag
        // When in Use
        if (count == 0) {
            permissions.requestWhenInUsePermission()
            goToNextPage(index: count)
            count = 1

        // Notifications
        } else if (count == 1) {
            permissions.requestNotificationPermission()
            goToNextPage(index: count)
            count = 2

        // Always
        } else if (count == 2) {
            permissions.requestAlwaysPermission()
            goToNextPage(index: count)
            count = 3

        // Bluetooth
        } else {
            permissions.requestBluetooth()
        }
        print(index)
    }

    func goToNextPage(index: Int) {
        swiftyOnboard.goToPage(index: index + 1, animated: true)
    }
}

extension OnboardingViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        //Number of pages in the onboarding:
        return 4
    }
    
    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
        //Return the background color for the page at index:
        return UIColor.infillionBlack
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()
        
//        print("Width: \(self.view.frame.width)")
//        print("Height: \(self.view.frame.height)")
//
//        print("MidX: \(self.view.frame.midX)")
//        print("MidY: \(self.view.frame.midY)")
        
        //Set the image on the page:
        let myLayer = CALayer()
        let myImage = UIImage(named: "Cannes_theme_app")?.cgImage
        myLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + 20.0)
        myLayer.contents = myImage
        view.layer.addSublayer(myLayer)
        
        let image = UIImage.init(named: "we_cannes_logo_lockuo")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: self.view.frame.midX * 0.40, y: self.view.frame.midY * 0.50, width: self.view.frame.width * 0.60, height: self.view.frame.height * 0.15)
        view.addSubview(imageView)
        
        // Set Title Label
        let title: UILabel = UILabel()
        updateLabel(label: title)
        print("ImageView Height: \(imageView.frame.maxY)")
        title.frame = CGRect(x: self.view.frame.midX * 0.40, y: imageView.frame.maxY * 1.05, width: self.view.frame.width * 0.75, height: self.view.frame.height * 0.25)
        title.numberOfLines = 2
        title.text = titleArray[index]
        title.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 35)
        view.addSubview(title)
        
        let subTitle: UILabel = UILabel()
        updateLabel(label: subTitle)
        subTitle.frame = CGRect(x: self.view.frame.midX * 0.40, y: imageView.frame.maxY * 1.35, width: 200, height: 200)
        subTitle.numberOfLines = 5
        subTitle.text = subTitleArray[index]
        subTitle.font = UIFont(name: "BeVietnamPro-ExtraLight", size: UIFont.labelFontSize)
        view.addSubview(subTitle)
        
        //Return the page for the given index:
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.isHidden = true
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        //Setup for the overlay buttons:
        overlay.skipButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.titleLabel?.font = UIFont(name: "Lato-Heavy", size: 16)
        
        //Return the overlay view:
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        print(Int(currentPage))
        overlay.continueButton.tag = Int(position)
        
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.continueButton.setTitle("Continue", for: .normal)
        } else {
            overlay.continueButton.setTitle("Get Started!", for: .normal)
        }
    }
    
    func updateLabel(label: UILabel) {
        label.textAlignment = .center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textColor = UIColor.white
    }
}
