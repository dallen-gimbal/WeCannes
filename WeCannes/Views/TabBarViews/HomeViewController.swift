//
//  HomeViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import Gimbal

class HomeViewController: UIViewController, PlaceManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        if (!Gimbal.isStarted()) {
            Gimbal.start()
        }
    }
    
    //MARK: Gimbal Methods
    func placeManager(_ manager: PlaceManager, didBegin visit: Visit) {
        
    }
    
    func placeManager(_ manager: PlaceManager, didEnd visit: Visit) {
        
    }

}
