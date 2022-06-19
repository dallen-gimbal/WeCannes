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
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func scheduleNotfications(day: Int, hour: Int, minute: Int, title: String) {
        let time = DateComponents(
          timeZone: TimeZone(identifier: "Europe/Paris"),
          year: 2022,
          month: 06,
          day: day,
          hour: hour,
          minute: minute
        )
        let content = UNMutableNotificationContent()
        content.title = title
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: time, repeats: false)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
//    
//    func scheduleTestNotfications() {
//        let time = DateComponents(
//          timeZone: TimeZone(identifier: "America/New_York"),
//          year: 2022,
//          month: 06,
//          day: 19,
//          hour: 13,
//          minute: 4
//        )
//        let content = UNMutableNotificationContent()
//        content.title = "Worked!!!"
//        let trigger = UNCalendarNotificationTrigger(
//                 dateMatching: time, repeats: false)
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: uuidString,
//                    content: content, trigger: trigger)
//
//        // Schedule the request with the system.
//        userNotificationCenter.add(request) { (error) in
//            if let error = error {
//                print("Notification Error: ", error)
//            }
//        }
//    }
}
