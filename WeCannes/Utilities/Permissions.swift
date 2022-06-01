//
//  Permissions.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/22/22.
//

import Foundation
import UserNotifications
import CoreLocation
import CoreBluetooth

class Permissions {
    let location = CLLocationManager.init()
    let storage = UserDefaults.init()
    
    //MARK: Request Permissions
    
    // Notification
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if error != nil {
                print("Error with notification request")
            }
            
            if (granted) {
                self.storage.set(true, forKey: "NotificationPermissions")
            } else {
                self.storage.set(true, forKey: "NotificationPermissions")
            }
        }
    }
    
    // When in Use
    func requestWhenInUsePermission() {
        location.requestWhenInUseAuthorization()
    }
    
    // Always
    func requestAlwaysPermission() {
        location.requestAlwaysAuthorization()
    }
    
    // Bluetooth
    func requestBluetooth() {
        CBCentralManager.init()
    }
    
    //MARK: Check Status
    
    // Location
    func checkLocationStatus() -> CLAuthorizationStatus {
        return location.authorizationStatus
    }
    
    // Notifications
    func checkNotificationStatus() -> Bool {
        return storage.bool(forKey: "NotificationPermissions")
    }
}
