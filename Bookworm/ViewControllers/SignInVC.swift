//
//  ViewController.swift
//  Bookworm
//
//  Created by Berkay Kuzu on 25.10.2022.
//

import UIKit
import Parse


class SignInVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "Bookworm📚"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
           charIndex += 1
            
        }
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    
                    //segue
                    self.performSegue(withIdentifier: "toBookVC", sender: nil)
                    
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Email/Username/Password ???")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && userNameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.email = emailText.text!
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    //Segue
                    self.performSegue(withIdentifier: "toBookVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Email/Username/Password ???")
        }
        
    }
    
    func makeAlert (titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
}

