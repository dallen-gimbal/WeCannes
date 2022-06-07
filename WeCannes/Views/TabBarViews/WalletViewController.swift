//
//  WalletViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import FirebaseFirestore

class WalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var redeemPointsButton: UIButton!
    @IBOutlet weak var earnPointsButton: UIButton!
    
    private var cellTitleArray = [String]()
    private var cellTimeArray = [String]()
    private let noVisitsArray = ["No Visits"]
    private let util = Utilities.init()
    
    override func viewWillAppear(_ animated: Bool) {
        util.updateButtonStyle(button: redeemPointsButton, title: "Redeem Tokens")
        pointsLabel.text = "\(util.checkPointValue(key: "Points"))"
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrieveVisitData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VisitsTableViewCell", for: indexPath) as? VisitsTableViewCell else { return UITableViewCell.init() }

        let visits = retrieveVisitData()
        let dwells = retrieveDwellData()

        cell.nameLabel.text = visits[indexPath.row]
        cell.nameLabel.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        cell.dwellLabel.text = dwells[indexPath.row]
        cell.dwellLabel.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func retrieveVisitData() -> [String] {
        return ((UserDefaults.init().array(forKey: "Visits") as? [String]) ?? ["No Visit Data"])
    }

    func retrieveDwellData() -> [String] {
        return ((UserDefaults.init().array(forKey: "Dwells") as? [String]) ?? ["No Dwell Data"])
    }
}

class VisitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dwellLabel: UILabel!
    
}
