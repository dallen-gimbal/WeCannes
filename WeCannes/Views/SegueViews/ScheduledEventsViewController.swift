//
//  ScheduledEventsViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import FirebaseFirestore

class ScheduledEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellReuseIdentifier = "scheduleCell"
    private var cellCount = 0
    private var cellTitleArray = [String]()
    private var cellTimeArray = [String]()
    private var cellUrlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateEventsList()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellCount // your number of cells here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        cell.textLabel?.text = cellTitleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(cellUrlArray[indexPath.row])
        DispatchQueue.main.async {
            self.present(Utilities.init().showTutorial(theUrl: self.cellUrlArray[indexPath.row]), animated: true)
        }
    }
    
    private func updateEventsList() {
        FirebaseFunctions.init().getCollectionData(collection: "events", completion: { documents, error in
            guard let docs = documents as QuerySnapshot? else { return }
            for doc in docs.documents {
                self.cellCount = docs.documents.count
                
                if let title = doc.data()["title"] {
                    self.cellTitleArray.append(title as! String)
                }
                if let time = doc.data()["time"] {
                    self.cellTimeArray.append(time as! String)
                }
                
                if let url = doc.data()["url"] {
                    self.cellUrlArray.append(url as! String)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }

}
