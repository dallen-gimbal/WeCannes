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
    
    private static var prizeCount = 0
    private static var titleArray = [String]()
    private static var imageUrlArray = [String]()
    
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
                RedeemPointsViewController.prizeCount = docs.documents.count
                
                if let title = doc.data()["title"] {
                    RedeemPointsViewController.titleArray.append(title as! String)
                }
                if let url = doc.data()["image_url"] {
                    RedeemPointsViewController.imageUrlArray.append(url as! String)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RedeemPointsViewController.prizeCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RedeemTokensTableViewCell", for: indexPath) as? RedeemTokensTableViewCell else { return UITableViewCell.init() }

        cell.titleLabel.text = RedeemPointsViewController.titleArray[indexPath.row]
        cell.titleLabel.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        let url = URL(string: RedeemPointsViewController.imageUrlArray[indexPath.row])
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//        imageView.image = UIImage(data: data!)

        cell.prizeImageView.image = UIImage(data: data!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
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
