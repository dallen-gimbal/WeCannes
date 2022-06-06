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
        
        updateLabels()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeManager.delegate = self
        
        if (!Gimbal.isStarted()) {
            Gimbal.start()
        }
        
    }
    
    //MARK: Gimbal Methods
    func placeManager(_ manager: PlaceManager, didBegin visit: Visit) {
        UserDefaults.init().set(true, forKey: "HadVisit")
        
        guard let points = visit.place.attributes.value(forKey: "Points") else { return }
        print("Fetched Points: \(points)")
        util.storePoints(value: "\(points)") {
            print("Stored Points: \(util.checkPointValue(key: "Points"))")
        }
        handlePlaceNotifications(visit: visit)
        print(visit.place.name)
    }
    
    func placeManager(_ manager: PlaceManager, didEnd visit: Visit) {
        UserDefaults.init().set(true, forKey: "HadVisit")
        handlePlaceNotifications(visit: visit)
    }
    
    // Safely handle Place Notifications
    func handlePlaceNotifications(visit: Visit) {
        // If someone doesn't place attributes in the Place, we don't want to crash the app
        guard let title = visit.place.attributes.string(forKey: "NotificationTitle") else { return }
        guard let body = visit.place.attributes.string(forKey: "NotificationBody") else { return }
        notifications.sendNotification(title: title, body: body)
    }
    
    private func updateLabels() {
        if util.checkValue(key: "Name") == "" || util.checkPointValue(key: "Points") == 0 {
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
