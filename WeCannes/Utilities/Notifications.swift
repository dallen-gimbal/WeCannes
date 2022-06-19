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
    private let utilities = Utilities.init()
    
    func sendNotification(title: String, body: String) {
        // 2
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        // 3
        var trigger: UNNotificationTrigger?
        trigger = UNTimeIntervalNotificationTrigger(
        timeInterval: 1,
        repeats: false)

        // 4
        if let trigger = trigger {
          let request = UNNotificationRequest(
              identifier: utilities.randomString(length: 6),
              content: content,
              trigger: trigger)
          // 5
          UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
              print(error)
            }
          }
        }
    }
    
    func scheduleNotification() {
      // 2
      let content = UNMutableNotificationContent()
      content.title = "Worked!!!"
      content.body = "Gentle reminder for your task!"

      // 3
      var trigger: UNNotificationTrigger?
      trigger = UNTimeIntervalNotificationTrigger(
      timeInterval: 1,
      repeats: false)

      // 4
      if let trigger = trigger {
        let request = UNNotificationRequest(
            identifier: utilities.randomString(length: 6),
            content: content,
            trigger: trigger)
        // 5
        UNUserNotificationCenter.current().add(request) { error in
          if let error = error {
            print(error)
          }
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
        let uuidString = utilities.randomString(length: 6)
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
}
