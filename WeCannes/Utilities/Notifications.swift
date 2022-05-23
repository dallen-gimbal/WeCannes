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
        notificationContent.badge = NSNumber(value: 3)
        
//        if let url = Bundle.main.url(forResource: "dune",
//                                    withExtension: "png") {
//            if let attachment = try? UNNotificationAttachment(identifier: "dune",
//                                                            url: url,
//                                                            options: nil) {
//                notificationContent.attachments = [attachment]
//            }
//        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
}
