//
//  LoginViewController.swift
//  ChatBoxParse
//
//  Created by Kun Huang on 9/27/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loginAlert(with message: String) {
        
        let alertController = UIAlertController(title: "Invalid Login", message: "Email or password is \(message)", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        
        let username = usernameText.text ?? ""
        let password = passwordText.text ?? ""
        
        if username.isEmpty || password.isEmpty {
            loginAlert(with: "empty")
        } else {
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                    self.loginAlert(with: "invalid")
                } else {
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                }
            }
        }
        
    }
    
    
    @IBAction func register(_ sender: UIButton) {
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
