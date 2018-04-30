//
//  ViewController.swift
//  Xevo
//
//  Created by Aditya Saxena on 01/04/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*if let _ = KeychainWrapper.standard.string(forKey: "uid") {
             KeychainWrapper.standard.removeObject(forKey: "uid")
            //performSegue(withIdentifier: "goToFeed", sender: nil)
        }*/
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    
    @IBAction func facebookBtnClicked(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) {(result, error) in
            if error != nil {
                print("Unable to authenticate with facebook")
            } else if result?.isCancelled == true {
                print("User cancelled")
            } else {
                print("Sucessfully Authenticated")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print("Unable to authenticate with Firebase")
            } else {
                print("Successfully Authenticated with Firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
            
        }
    }
    
    @IBAction func SignInClicked(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("User authenticated with Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    print("Sign up part/Sign in failure")
                }
            })
        }
        
        
    }
    
    
    @IBAction func SignUpClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToSignUp", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func completeSignIn(id: String) {
        //let keychain = KeychainWrapper.standard.set(id, forKey: "uid")
        //print("Data saved to Keychain: \(keychain)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }

}

