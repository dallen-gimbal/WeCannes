//
//  HomeViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import Gimbal
import FirebaseFirestore

class HomeViewController: UIViewController, PlaceManagerDelegate {
    
    @IBOutlet weak var partnerButton: UIButton!
    @IBOutlet weak var redeemPointsButton: UIButton!
    @IBOutlet weak var earnPointsButton: UIButton!
    @IBOutlet weak var upcomingEventsButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    let placeManager = PlaceManager()
    private let util = Utilities.init()
    
    override func viewWillAppear(_ animated: Bool) {
        util.updateButtonStyle(button: redeemPointsButton, title: "Redeem Tokens")
        util.updateButtonStyle(button: upcomingEventsButton, title: "Upcoming Events")
        util.dynamicallyChangeButtonSize(button: earnPointsButton)
        
        updateLabels()
        print(placeManager.currentVisits())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!Gimbal.isStarted()) {
            Gimbal.start()
        }
        
        self.placeManager.delegate = self
        
    }
    
    private func updateLabels() {
        if util.checkValue(key: "Name") == "" {
            FirebaseFunctions.init().getCollectionData(collection: "users") { documents, error in
                guard let users = documents as QuerySnapshot? else { return }
                for user in users.documents {
                    guard let uid = user.data()["uid"] as? String else { return }
                    if uid == self.util.checkValue(key: "UID") {
                        
                        guard let name = user.data()["name"] as? String else { return }
                        guard let points = user.data()["points"] as? Int else { return }
                        
                        UserDefaults.init().setValue(name, forKey: "Name")
                        UserDefaults.init().set(points, forKey: "Points")
                        
                        self.nameLabel.text = name
                        self.pointsLabel.text = String(points)
                    }
                }
            }
        } else {
            nameLabel.text = util.checkValue(key: "Name")
            pointsLabel.text = "\(util.checkPointValue(key: "Points"))"
        }
    }

}
