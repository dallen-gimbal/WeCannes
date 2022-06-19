//
//  ScheduledEventsViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import FirebaseFirestore
import WebKit

class ScheduledEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellReuseIdentifier = "scheduleCell"
    private var webView = WKWebView()

    private var cellCount = 0
    private var cellTitleArray = [String]()
    private var cellTimeArray = [String]()
    private var cellUrlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        updateEventsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellCount // your number of cells here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduledEventsTableViewCell", for: indexPath) as? ScheduledEventsTableViewCell else { return UITableViewCell.init() }

        cell.eventNameLabel.text = cellTitleArray[indexPath.row]
        cell.eventNameLabel.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        cell.eventTimeLabel.text = cellTimeArray[indexPath.row]
        cell.eventTimeLabel.font = UIFont(name: "BeVietnamPro-ExtraLight", size: 20.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(cellUrlArray[indexPath.row])
        DispatchQueue.main.async {
//            self.present(Utilities.init().showSafari(theUrl: self.cellUrlArray[indexPath.row]), animated: true)
            self.webView = WKWebView(frame: CGRect(x: 0, y: 0,
                                                   width: self.view.frame.width,
                                                   height: self.view.frame.height))
                                     
            self.webView.loadURL(self.cellUrlArray[indexPath.row])
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

class ScheduledEventsTableViewCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    
}

