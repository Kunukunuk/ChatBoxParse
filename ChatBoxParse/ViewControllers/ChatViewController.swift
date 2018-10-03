//
//  ChatViewController.swift
//  ChatBoxParse
//
//  Created by Kun Huang on 10/2/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageText: UITextField!
    var tableData: [String] = []
    var dateTable: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedRowHeight = 60
        
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
        let chatMessage = PFObject(className: "Message")
        
        chatMessage["text"] = messageText.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.messageText.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
    }
    
    func getMessage() {
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground { (messages, error) in
            if error == nil {
                if let messages = messages {
                    for message in messages {
                        self.dateTable.append(message.createdAt!)
                        self.tableData.append(message["text"] as! String)
                        self.tableView.reloadData()
                        
                    }
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    @objc func onTimer() {
        
        dateTable.removeAll()
        tableData.removeAll()
        getMessage()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableData.isEmpty {
            return 0
        } else {
            return tableData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let message = tableData[indexPath.row]
        let date = dateTable[indexPath.row]
        
        cell.dateLabel.text = "\(date)"
        cell.textLabel?.text = message
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Logout" {
            PFUser.logOutInBackground { (error: Error?) in
                // PFUser.current() will now be nil
            }
        }
    }

}
