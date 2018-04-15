//
//  SignUpVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 05/04/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var SecondName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if let email = Email.text, let pwd = pwdField.text {
        
        Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
            if error != nil {
                print("Unable to create user")
            } else {
                print("Successfully authenticated with firebase")
            }
        })
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
