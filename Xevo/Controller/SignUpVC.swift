//
//  SignUpVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 05/04/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpVC: UIViewController {

    var dbReference: DatabaseReference?
    var text = "error"
    var useruid: String!
    
    @IBAction func termsofUse(_ sender: Any) {
        self.performSegue(withIdentifier: "goToTerms", sender: self)
    }
    
    @IBOutlet weak var FirstName: UITextField!
    
    @IBOutlet weak var SecondName: UITextField!
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var pwdField: UITextField!
    
    /*@IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var SecondName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirstName.setBottomBorder()
        SecondName.setBottomBorder()
        Email.setBottomBorder()
        pwdField.setBottomBorder()
        
        pwdField.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if let email = Email.text, let pwd = pwdField.text, let fn = FirstName.text, let sn = SecondName.text {
        
        Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
            if error != nil {
                print("Unable to create user")
                
                if (fn == "") {
                    self.FirstName.layer.shadowColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
                }
                
                if (sn == "") {
                    self.SecondName.layer.shadowColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
                }
                
                var tem = self.pwdField.text?.characters.count
                
                if (pwd == "" || tem! < 4) {
                
                self.pwdField.layer.shadowColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
                } else {
                   self.Email.layer.shadowColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
                }
                
            } else {
                
                self.useruid = user?.uid
                print("Successfully authenticated with firebase with user id: ")
                
            let userr = ["casesAnswered": "0", "email": email, "firstName": fn, "lastName": sn, "isConsultant": "none", "rating": "-1", "device": UIDevice.current.identifierForVendor!.uuidString]
                
                self.dbReference = Database.database().reference()
                self.dbReference?.child("Users").child(self.useruid).setValue(userr)
                
                self.text = fn + " " + sn
                
                self.performSegue(withIdentifier: "gotofed", sender: self)
            }
        })
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goBackToSignIn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //      let sc = segue.destination as! FeedVC
    //    sc.tempVal = text
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
