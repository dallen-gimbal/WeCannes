//
//  WooHooViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/5/22.
//

import UIKit
import Firebase
import Gimbal

class WooHooViewController: UIViewController {

    @IBOutlet weak var starView: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
    
    private let placeManager = PlaceManager()
    
    override func viewWillAppear(_ animated: Bool) {
        if placeManager.currentVisits().isEmpty {
            pointsLabel.text = "More Tokens Earned"
        } else {
            var count = placeManager.currentVisits().count - 1
            if count < 0 {
                count = 0
            }
            let points = placeManager.currentVisits()[count].place.attributes.string(forKey: "Points") ?? "More"
            pointsLabel.text = "\(points) Tokens Earned"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}
