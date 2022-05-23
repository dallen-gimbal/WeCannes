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
    
    // Outlets
    @IBOutlet weak var swiftyOnboard: SwiftyOnboard!
    
    // Variables
    private let permissions = Permissions()
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swiftyOnboard.delegate = self
        swiftyOnboard.dataSource = self
    }
    
    @objc func handleContinue(sender: UIButton) {
//        var index = sender.tag
        if (count == 0) {
            permissions.requestWhenInUsePermission()
            goToNextPage(index: count)
            count = 1
        } else if (count == 1) {
            permissions.requestNotificationPermission()
            goToNextPage(index: count)
            count = 2
        } else if (count == 2) {
            permissions.requestAlwaysPermission()
            goToNextPage(index: count)
            count = 3
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
            return 4
        }

    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        
        if index == 0 {
            //On the first page, change the text in the labels to say the following:
            page.title.text = "Planet earth is extraordinary"
            page.subTitle.text = "Earth, otherwise known as the World, is the third planet from the Sun."
        } else if index == 1 {
            //On the second page, change the text in the labels to say the following:
            page.title.text = "The mystery of\n outer space"
            page.subTitle.text = "Outer space or just space, is the void that exists between celestial bodies, including Earth."
        } else if index == 2 {
            //On the thrid page, change the text in the labels to say the following:
            page.title.text = "Extraterrestrial\n life"
            page.subTitle.text = "Extraterrestrial life, also called alien life, is life that does not originate from Earth."
        } else {
            //On the thrid page, change the text in the labels to say the following:
            page.title.text = "Uknown Worlds"
            page.subTitle.text = "There are unkonwn worlds, also called alien life, is life that does not originate from Earth."
        }
        return page
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay.init()
        overlay.skipButton.isHidden = true
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        return overlay
    }
}
