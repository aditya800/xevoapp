//
//  ReferralVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 02/08/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ReferralVC: UIViewController {
    
    @IBOutlet weak var codelet: UILabel!
    @IBOutlet weak var deepone: UILabel!
    @IBOutlet weak var deeptwo: UILabel!
    
    @IBOutlet weak var promod: UITextField!
    
    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        promod.layer.borderWidth = 1
        promod.layer.borderColor = UIColor.white.cgColor
        
        deepone.isHidden = true
        deeptwo.isHidden = true
        
        var fn: String!
        //var sn: String!
        
        let ref = Database.database().reference()
        let id = Auth.auth().currentUser?.uid
        
        ref.child("Users").child(id!).child("firstName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            fn = snapshot.value as? String
            print(fn!)
            
            self.codelet.text = fn + "bd03909"
            
        })
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addpromo(_ sender: Any) {
        
        let databaseRef = Database.database().reference()
        
        if(promod.text == "") {
            self.deepone.text = "Promo code not found!"
            self.deeptwo.text = "Please try entering the code again."
            self.deepone.isHidden = false
            self.deeptwo.isHidden = false
        } else {
        
        databaseRef.child("Referrals").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            if snapshot.hasChild(self.promod.text!) {
                
                let user = Auth.auth().currentUser?.uid
                databaseRef.child("Users").child(user!).child("credits").setValue("10")
                databaseRef.child("Users").child(user!).child("used").setValue(self.promod.text)
                //databaseRef.child("Referrals").child(self.promod.text!).removeValue()
                self.deepone.isHidden = false
                self.deeptwo.isHidden = false
                
            } else {
                
                self.deepone.text = "Promo code not found!"
                self.deeptwo.text = "Please try entering the code again."
                self.deepone.isHidden = false
                self.deeptwo.isHidden = false
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
