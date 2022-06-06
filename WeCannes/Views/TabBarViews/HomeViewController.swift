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
    private let notifications = LocalNotifications.init()
    
    override func viewWillAppear(_ animated: Bool) {
        util.updateButtonStyle(button: redeemPointsButton, title: "Redeem Tokens")
        util.updateButtonStyle(button: upcomingEventsButton, title: "Upcoming Events")
        util.dynamicallyChangeButtonSize(button: earnPointsButton)
        
        if util.checkValue(key: "Name") == "" {
            FirebaseFunctions.init().getCollectionData(collection: "users") { documents, error in
                print("Fetched")
                guard let users = documents as QuerySnapshot? else { return }
                for user in users.documents {
                    guard let uid = user.data()["uid"] as? String else { return }
                    if uid == self.util.checkValue(key: "UID") {
                        guard let name = user.data()["name"] as? String else { return }
                        UserDefaults.init().setValue(name, forKey: "Name")
                        self.nameLabel.text = name
                    }
                }
            }
        } else {
            nameLabel.text = util.checkValue(key: "Name")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!Gimbal.isStarted()) {
            Gimbal.start()
        }
        
        self.placeManager.delegate = self
        
    }
    
    //MARK: Gimbal Methods
    func placeManager(_ manager: PlaceManager, didBegin visit: Visit) {
        handlePlaceNotifications(visit: visit)
        print(visit.place.name)
    }
    
    func placeManager(_ manager: PlaceManager, didEnd visit: Visit) {
        handlePlaceNotifications(visit: visit)
        
    }
    
    // Safely handle Place Notifications
    func handlePlaceNotifications(visit: Visit) {
        // If someone doesn't place attributes in the Place, we don't want to crash the app
        guard let title = visit.place.attributes.string(forKey: "NotificationTitle") else { return }
        guard let body = visit.place.attributes.string(forKey: "NotificationBody") else { return }
        notifications.sendNotification(title: title, body: body)
    }

}
