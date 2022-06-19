//
//  RedeemPointsViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import FirebaseFirestore

class RedeemPointsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pointsLabel: UILabel!
    
    private var prizeCount = 0
    private var titleArray = [String]()
    private var imageUrlArray = [String]()
    private var subtitleArray = [String]()
    private var pointsArray = [String]()
    private var bodyArray = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        retrievePrizes()
        pointsLabel.text = "\(Utilities.init().checkPointValue(key: "Points"))"
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    

    func retrievePrizes() {
        FirebaseFunctions.init().getCollectionData(collection: "prizes", completion: { documents, error in
            guard let docs = documents as QuerySnapshot? else { return }
            for doc in docs.documents {
                print(doc.data())
                self.prizeCount = docs.documents.count
                
                if let title = doc.data()["title"] {
                    self.titleArray.append(title as? String ?? "")
                }
                if let image_url = doc.data()["image_url"] {
                    self.imageUrlArray.append(image_url as? String ?? "")
                }
                if let points = doc.data()["points"] {
                    self.pointsArray.append(points as? String ?? "")
                }
                if let subtitle = doc.data()["subtitle"] {
                    self.subtitleArray.append(subtitle as? String ?? "")
                }
                if let body = doc.data()["body"] {
                    self.bodyArray.append(body as? String ?? "")
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prizeCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RedeemTokensTableViewCell", for: indexPath) as? RedeemTokensTableViewCell else { return UITableViewCell.init() }

        cell.titleLabel.text = self.titleArray[indexPath.row]
        cell.titleLabel.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        cell.pointsLabel.text = "\(self.pointsArray[indexPath.row]) Points"
        cell.pointsLabel.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        cell.subtitleLabel.text = self.subtitleArray[indexPath.row]
        cell.subtitleLabel.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        cell.bodyLabel.text = self.bodyArray[indexPath.row]
        cell.bodyLabel.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        if let url = URL(string: self.imageUrlArray[indexPath.row]) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    cell.prizeImageView.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Happened")
        if Int(pointsArray[indexPath.row]) ?? 0 == 150 {
            FirebaseFunctions.init().redeemPrize(vc: self, points: Int(pointsArray[indexPath.row]) ?? 0, prize: titleArray[indexPath.row]) {
                Utilities.init().displayAlert(vc: self, message: "Lookout for an email from Infillion on your prize!", title: "Congratulations!")
                self.pointsLabel.text = "\(Utilities.init().checkPointValue(key: "Points"))"
            }
        } else {
            Utilities.init().displayAlert(vc: self, message: "All tokens will be donated to support Ukraine!", title: "Congratulations!")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156.00
    }
}

class RedeemTokensTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var prizeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
}
