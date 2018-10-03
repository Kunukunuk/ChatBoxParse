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
    var tableData: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedRowHeight = 50
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
    
    @objc func onTimer() {
        
        //let object = PFObject(className: "Message")
        
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground { (messages, error) in
            if error == nil {
                print("Messages: \(messages)")
                
                
                /*
                 for post in posts {
                 
                 let date = post.createdAt
                 let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss a" //Input Format
                 dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                 let stringDate = dateFormatter.string(from: date!)
                 let currentDate = self.UTCToLocal(UTCDateString: stringDate)
                 
                 let caption = post["caption"] as! String
                 let image = post["media"]
                 
                 self.tableData.append([currentDate: [image as AnyObject, caption as AnyObject]])
                 self.tableView.reloadData()
                 }
                */
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
