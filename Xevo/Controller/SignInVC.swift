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
    
    var userId: String!
    
    @IBOutlet weak var fbImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
       emailField.setBottomBorder()
       pwdField.setBottomBorder()
       fbImage.layer.cornerRadius = 25
        
       pwdField.isSecureTextEntry = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            performSegue(withIdentifier: "gotofeed", sender: nil)
    }
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
                    self.userId = user.uid
                    
                    let databaseRef = Database.database().reference()
                    
                    databaseRef.child("Users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                        
                        if snapshot.hasChild(user.uid){
                            
                            print("true rooms exist")
                            
                        } else {
                            
                    let nam = user.displayName
                    let email = user.email
                    
                    var myStringArr = nam?.components(separatedBy: " ")
                            
                            let fn: String = myStringArr! [0]
                            let sn: String = myStringArr! [1]
                            
                    let userr = ["casesAnswered": "0", "email": email!, "firstName": fn, "lastName": sn, "isConsultant": "none", "rating": "-1", "device": UIDevice.current.identifierForVendor!.uuidString]
                            
                        databaseRef.child("Users").child(user.uid).setValue(userr)
                            
                        print("false room doesn't exist \(fn) \(sn) \(email!)")
                            
                        }
                    })
                    
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
                        self.userId = user.uid
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    self.emailField.layer.shadowColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
                    self.pwdField.layer.shadowColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
                    print("Sign up part/Sign in failure")
                }
            })
        }
        
    }
    
    @IBAction func SignUpClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToSignUp", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotofeed" {
            if let destination = segue.destination as? FeedVC {
            if userId != nil {
                  destination.userId = userId
            }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func completeSignIn(id: String) {
        let keychain = KeychainWrapper.standard.set(id, forKey: "uid")
        print("Data saved to Keychain: \(keychain)")
        performSegue(withIdentifier: "gotofeed", sender: nil)
    }

}

