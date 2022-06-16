//
//  Notifications.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/23/22.
//

import Foundation
import UserNotifications

class LocalNotifications {
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    func sendNotification(title: String, body: String) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.badge = NSNumber(value: 1)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: "PlaceEvent",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
