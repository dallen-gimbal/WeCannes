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
    
    //MARK: Request Permissions
    
    // Notification
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if error != nil {
                print("Error with notification request")
            }
            
            if (granted) {
                print("Granted")
            } else {
                print("Not Granted")
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
        
    }
    
    //MARK: Check Status
    
    // Location
    func checkLocationStatus() -> CLAuthorizationStatus {
        if location.authorizationStatus == .authorizedWhenInUse {
            print("Authorized When in Use")
            return .authorizedWhenInUse
        } else if location.authorizationStatus == .authorizedAlways {
            print("Authorized Always")
            return .authorizedAlways
        } else if location.authorizationStatus == .denied {
            print("Denied")
            return .denied
        } else if location.authorizationStatus == .notDetermined {
            print("Not Determined")
            return .notDetermined
        } else {
            print("Restricted")
            return .restricted
        }
    }
}
