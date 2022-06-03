//
//  PartnerViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/2/22.
//

import UIKit
import FirebaseFirestore

class PartnerViewController: UIViewController {
    
    private var partnerCount = 0
    private var companyArray = [String]()
    private var landingUrlArray = [String]()
    private var imageUrlArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        updatePartnerList()
    }
    

    func updatePartnerList() {
        FirebaseFunctions.init().getCollectionData(collection: "partners", completion: { documents, error in
            guard let docs = documents as QuerySnapshot? else { return }
            for doc in docs.documents {
                print(doc.data())
                self.partnerCount = docs.documents.count
                
                if let company = doc.data()["company"] {
                    self.companyArray.append(company as! String)
                }
                if let image = doc.data()["image_url"] {
                    self.imageUrlArray.append(image as! String)
                }
                if let landing = doc.data()["landing_url"] {
                    self.landingUrlArray.append(landing as! String)
                }
                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
            }
        })
    }

}
