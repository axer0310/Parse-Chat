//
//  LoginViewController.swift
//  Parse Chat
//
//  Created by Jungyoon Yu on 2/23/17.
//  Copyright © 2017 Jungyoon Yu& Arthur Wu. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        var user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        
        // other fields can be set just like with PFObject
        
        user.signUpInBackground { (result, error) in
            if (self.emailTextField.text! == "" && self.passwordTextField.text! == "")
            {
                print(error?.localizedDescription)
                let alertController = UIAlertController(title: "Error!", message: "Please add Email/password!", preferredStyle: .alert)
                // create a cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }

            }
            else if let error = error {
                print(error.localizedDescription)
                let alertController = UIAlertController(title: "Error!", message: "Please add Email/password!", preferredStyle: .alert)
                // create a cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            } else {
                print("We signed up yay!")
                self.performSegue(withIdentifier: "firstView", sender: nil)
                // TODO Go to next screen
                
            }
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                print("login error")
                let alertController = UIAlertController(title: "Error!", message: "Please add Email/password!", preferredStyle: .alert)
                // create a cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                
            } else {
                // TODO Go to next screen
                self.performSegue(withIdentifier: "firstView", sender: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
