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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func updateLabels() {
        if !UserDefaults.init().bool(forKey: "HadVisit") {
            if util.checkPointValue(key: "Points") == 0 {
                FirebaseFunctions.init().getCollectionData(collection: "users") { documents, error in
                    guard let users = documents as QuerySnapshot? else { return }
                    for user in users.documents {
                        guard let uid = user.data()["uid"] as? String else { return }
                        if uid == self.util.checkValue(key: "UID") {
                            
                            guard let points = user.data()["points"] as? Int else { return }
                            
                            UserDefaults.init().set(points, forKey: "Points")
                            
                            self.pointsLabel.text = String(points)
                        }
                    }
                }
            }
        } else {
            pointsLabel.text = "\(util.checkPointValue(key: "Points"))"
        }
    }

}
