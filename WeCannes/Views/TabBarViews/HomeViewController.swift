//
//  HomeViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import Gimbal

class HomeViewController: UIViewController, PlaceManagerDelegate {
    
    @IBOutlet weak var redeemPointsButton: UIButton!
    @IBOutlet weak var earnPointsButton: UIButton!
    @IBOutlet weak var upcomingEventsButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    let notifications = LocalNotifications.init()
    let placeManager = PlaceManager()
    private let util = Utilities.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!Gimbal.isStarted()) {
            Gimbal.start()
        }
        
        placeManager.delegate = self
        
        util.updateButtonStyle(button: redeemPointsButton, title: "Redeem Points")
        util.updateButtonStyle(button: earnPointsButton, title: "Earn Points")
        util.updateButtonStyle(button: upcomingEventsButton, title: "Upcoming Events")
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
