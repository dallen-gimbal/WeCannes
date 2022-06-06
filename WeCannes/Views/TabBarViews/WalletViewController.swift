//
//  WalletViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import FirebaseFirestore

class WalletViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeNameLabel: UITableView!
    @IBOutlet weak var dwellTimeLabel: UITableView!
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var redeemPointsButton: UIButton!
    @IBOutlet weak var earnPointsButton: UIButton!
    
    private let util = Utilities.init()
    
    override func viewWillAppear(_ animated: Bool) {
        util.updateButtonStyle(button: redeemPointsButton, title: "Redeem Tokens")
        pointsLabel.text = "\(util.checkPointValue(key: "Points"))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
