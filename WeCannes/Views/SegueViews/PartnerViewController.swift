//
//  PartnerViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/2/22.
//

import UIKit
import FirebaseFirestore

class PartnerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var partnerCount = 0
    private var companyArray = [String]()
    private var landingUrlArray = [String]()
    private var imageUrlArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        updatePartnerList()
        
        self.tableView.backgroundColor = .white
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
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PartnerTableViewCell", for: indexPath) as? PartnerTableViewCell else { return UITableViewCell.init() }
        
        if let url = URL(string: self.imageUrlArray[indexPath.row]) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    cell.logoImage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.landingUrlArray[indexPath.row])
        print("Tapped")
        DispatchQueue.main.async {
            self.present(Utilities.init().showSafari(theUrl: self.landingUrlArray[indexPath.row]), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.00
    }
    
//    func table
//    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.backgroundColor = .clear
//    }

}

class PartnerTableViewCell: UITableViewCell {
    @IBOutlet weak var logoImage: UIImageView!
    
}
