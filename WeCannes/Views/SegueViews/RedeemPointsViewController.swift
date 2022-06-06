//
//  RedeemPointsViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import FirebaseFirestore

class RedeemPointsViewController: UIViewController {
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    private var prizeCount = 0
    private var companyArray = [String]()
    private var imageUrlArray = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        retrievePrizes()
        pointsLabel.text = "\(Utilities.init().checkPointValue(key: "Points"))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    func retrievePrizes() {
        FirebaseFunctions.init().getCollectionData(collection: "prizes", completion: { documents, error in
            guard let docs = documents as QuerySnapshot? else { return }
            for doc in docs.documents {
                print(doc.data())
                self.prizeCount = docs.documents.count
                
                if let title = doc.data()["title"] {
                    self.companyArray.append(title as! String)
                }
                if let url = doc.data()["url"] {
                    self.imageUrlArray.append(url as! String)
                }
                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
            }
        })
    }
}
