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
//    private var count = 0
    
    @IBOutlet var swiftyOnboard: SwiftyOnboard!
    
    //    var swiftyOnboard: SwiftyOnboard!
    var titleArray: [String] = ["This App Uses Location", "Notifications Enhance Your Experience", "Always Improves Your Experience", "Experience Beacon Magic"]
    var subTitleArray: [String] = ["Unlock onsite reward opportunities and grow your digital wallet by enabling location services", "Notifications may include alerts and will honor your time and attention by notifying you when reward opportunities exist. This can be configured in settings", "Your location is used to unlock reward opportunities, event happenings, and better app experiences", "We use Bluetooth to know when you're visiting an Infillion or Partner activation so we can alert you to special events and reward opportunities."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swiftyOnboard = SwiftyOnboard(frame: view.frame, style: .light)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }
    
    @objc func handleContinue(sender: UIButton) {
        var count = sender.tag
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
            StoryboardLogic.init().tabBarSegue()
        }
        print(index)
    }

    func goToNextPage(index: Int) {
        swiftyOnboard.goToPage(index: index + 1, animated: true)
    }
}

extension OnboardingViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = OnboardingPage.instanceFromNib() as? OnboardingPage
        view?.titleLabel.numberOfLines = 2
        view?.titleLabel.text = titleArray[index]
        view?.subTitleLabel.numberOfLines = 5
        view?.subTitleLabel.text = subTitleArray[index]
        
        return view
    }
    
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        //Number of pages in the onboarding:
        return 4
    }
    
    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
        //Return the background color for the page at index:
        return UIColor.infillionBlack
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.isHidden = true
        overlay.pageControl.isHidden = true
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        //Setup for the overlay buttons:
        overlay.skipButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.titleLabel?.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 16)
        
        //Return the overlay view:
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        print(Int(currentPage))
        overlay.continueButton.tag = Int(position)
//
//        if currentPage == 0.0 || currentPage == 1.0 {
//            overlay.continueButton.setTitle("Continue", for: .normal)
//        } else {
//            overlay.continueButton.setTitle("Get Started!", for: .normal)
//        }
    }
}
