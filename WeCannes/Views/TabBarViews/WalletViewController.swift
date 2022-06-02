//
//  WalletViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet weak var redeemPointsButton: UIButton!
    @IBOutlet weak var earnPointsButton: UIButton!
    @IBOutlet weak var upcomingEventsButton: UIButton!
    
    private let util = Utilities.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        util.updateButtonStyle(button: redeemPointsButton, title: "Redeem Points")
        util.updateButtonStyle(button: earnPointsButton, title: "Earn Points")
        util.updateButtonStyle(button: upcomingEventsButton, title: "Upcoming Events")
    }

}
