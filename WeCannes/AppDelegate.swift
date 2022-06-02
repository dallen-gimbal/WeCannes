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

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let permissions = Permissions()
    private let store = UserDefaults.init()
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Firebase
        FirebaseApp.configure()
        
        // Gimbal
        Gimbal.setAPIKey("0722b77d-831d-4121-91d7-ca2a032ad99d", options: [:])
        
        // Permissions
        let locationStatus = permissions.checkLocationStatus()
        if locationStatus == .authorizedAlways || locationStatus == .authorizedWhenInUse {
            // Start Gimbal
            Gimbal.start()
            if (Gimbal.isStarted()) {
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


}

