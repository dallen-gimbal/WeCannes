//
//  Permissions.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/22/22.
//

import Foundation
import UserNotifications
import CoreLocation

class Permissions {
    let location = CLLocationManager.init()
    
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if error != nil {
                // Handle the error here.
            }
            
            if (granted) {
                print("Granted")
            } else {
                print("Not Granted")
            }
        }
    }
    
    func requestWhenInUsePermission() {
        location.requestWhenInUseAuthorization()
    }
    
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
