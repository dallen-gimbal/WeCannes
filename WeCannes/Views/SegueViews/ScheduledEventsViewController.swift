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
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        cell.textLabel?.text = cellTitleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        // set the text from the data model
//        cell.textLabel?.text = self.animals[indexPath.row]
        
        return cell
    }

    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
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
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }

}
