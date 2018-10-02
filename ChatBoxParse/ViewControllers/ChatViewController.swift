//
//  ChatViewController.swift
//  ChatBoxParse
//
//  Created by Kun Huang on 10/2/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    
    @IBOutlet weak var messageText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
