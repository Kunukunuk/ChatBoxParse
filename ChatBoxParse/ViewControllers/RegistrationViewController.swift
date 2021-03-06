//
//  RegistrationViewController.swift
//  ChatBoxParse
//
//  Created by Kun Huang on 9/27/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import Parse

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func registerAlert(reason: String) {
        
        let alertController = UIAlertController(title: "Registration Error", message: "Can't register this account because \(reason)", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    @IBAction func registerAccount(_ sender: UIButton) {
        let newUser = PFUser()
        
        newUser["name"] = nameText.text
        newUser.username = usernameText.text
        newUser.password = passwordText.text
        newUser.email = emailText.text
        
        activity.startAnimating()
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("created new user")
                self.performSegue(withIdentifier: "finishedRegister", sender: nil)
                self.activity.stopAnimating()
            } else {
                
                self.registerAlert(reason: error!.localizedDescription)
                print(error?.localizedDescription)
                self.activity.stopAnimating()
            }
        }
    }

}
