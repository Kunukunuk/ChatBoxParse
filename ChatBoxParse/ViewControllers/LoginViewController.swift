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
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        checkIsLoggedIn()
    }
    
    func checkIsLoggedIn () {
        if PFUser.current() != nil {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    func loginAlert(with message: String? = "Email or password is empty") {
        
        let alertController = UIAlertController(title: "Invalid Login", message: "\(message!)", preferredStyle: .alert)
        
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
            loginAlert()
        } else {
            loading.startAnimating()
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                    self.loginAlert(with: error.localizedDescription)
                    self.loading.stopAnimating()
                } else {
                    print("User logged in successfully")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    self.loading.stopAnimating()
                    // display view controller that needs to shown after successful login
                }
            }
        }
        
    }
    
    @IBAction func unwindToLoginScreen(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
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
