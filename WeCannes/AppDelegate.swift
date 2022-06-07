//
//  AppDelegate.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import FirebaseCore
import Gimbal
import CloudKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, PlaceManagerDelegate {

    private let permissions = Permissions()
    private let store = UserDefaults.init()
    private let notifications = LocalNotifications.init()
    private let util = Utilities.init()
    let placeManager = PlaceManager()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Make life easy
        IQKeyboardManager.shared.enable = true
        
        // Firebase
        FirebaseApp.configure()
        
        // Gimbal
        Gimbal.setAPIKey("0722b77d-831d-4121-91d7-ca2a032ad99d", options: [:])
        
        // Permissions
        let locationStatus = permissions.checkLocationStatus()
        if locationStatus == .authorizedAlways || locationStatus == .authorizedWhenInUse {
            // Start Gimbal
            Gimbal.start()
            self.placeManager.delegate = self
            if Gimbal.isStarted() {
                print("Gimbal started")
            }
        } else {
            if locationStatus == .notDetermined {
                print("Not requested")
            } else {
                print("Denied")
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK: Gimbal Methods
    func placeManager(_ manager: PlaceManager, didBegin visit: Visit) {
        UserDefaults.init().set(true, forKey: "HadVisit")
        print("Place Enter: \(visit.place.name)")
        
        handlePlaceNotifications(visit: visit)
    }
    
    func placeManager(_ manager: PlaceManager, didEnd visit: Visit) {
        UserDefaults.init().set(true, forKey: "HadVisit")
        print("Place Exit: \(visit.place.name)")
        
        // Logic for Place Data
        let name = visit.place.name
        let dwell = visit.dwellTime
        
        var visits = store.array(forKey: "Visits") as? [String] ?? []
        var dwells = store.array(forKey: "Dwells") as? [String] ?? []
        
        visits.append(name)
        dwells.append("\(Int(round(dwell))) Seconds")
        
        // Set the UserDefaults
        store.set(visits, forKey: "Visits")
        store.set(dwells, forKey: "Dwells")
        
        for i in visits {
            print(i)
        }
        
        // Logic for Points
        guard var points = visit.place.attributes.string(forKey: "Points") else { return }
        points = "\(dwellTimeMultiplier(points: points, dwell: Int(round(dwell))))"
        util.storePoints(value: points) {
            
        }
    }
    
    // Safely handle Place Notifications
    func handlePlaceNotifications(visit: Visit) {
        // If someone doesn't place attributes in the Place, we don't want to crash the app
        guard let title = visit.place.attributes.string(forKey: "NotificationTitle") else { return }
        guard let body = visit.place.attributes.string(forKey: "NotificationBody") else { return }
        notifications.sendNotification(title: title, body: body)
    }
    
    private func dwellTimeMultiplier(points: String, dwell: Int) -> Int {
        let score = Int(points) ?? 0
        if dwell < 120 {
            return score
        } else if dwell >= 120 && dwell < 240 {
            return score * 2
        } else if dwell >= 120 && dwell < 240 {
            return score * 3
        } else if dwell >= 120 && dwell < 240 {
            return score * 4
        }
        return score * 5
    }


}

