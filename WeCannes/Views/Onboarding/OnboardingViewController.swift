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
    
    @IBOutlet weak var swiftyOnboard: SwiftyOnboard!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftyOnboard = SwiftyOnboard(frame: view.frame)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        if (index == 0) {
            
        } else if (index == 1) {
            
        } else if (index == 2) {
            
        } else {
            
        }
        swiftyOnboard?.goToPage(index: index + 1, animated: true)
    }

}

extension OnboardingViewController: SwiftyOnboardDataSource {

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
}
