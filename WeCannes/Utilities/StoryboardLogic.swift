//
//  StoryboardLogic.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/2/22.
//

import UIKit

class StoryboardLogic {
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func tabBarSegue() {
        let mainTabBarController = storyboard.instantiateViewController(identifier: "CustomTabBarController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(mainTabBarController)
    }
    
    func onboardingSegue() {
        let onboardingConroller = storyboard.instantiateViewController(identifier: "OnboardingViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(onboardingConroller)
    }
}
