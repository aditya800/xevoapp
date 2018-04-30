//
//  FeedVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 19/04/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {
    
    var menuCheckr = true
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        leadingConstraint.constant = -190
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showView(_ sender: Any) {
        if(menuCheckr) {
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            leadingConstraint.constant = -190
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        menuCheckr = !menuCheckr
    }
    
    
    @IBAction func MyCases(_ sender: Any) {
    }
    
    
    @IBAction func askaquestion(_ sender: Any) {
        performSegue(withIdentifier: "gotoquestion", sender: nil)
    }
    
    @IBAction func answeracase(_ sender: Any) {
    }
    
    @IBAction func settings(_ sender: Any) {
    }
    
    
    
    
/*    @IBAction func signOut(_ sender: AnyObject) {
        let k = KeychainWrapper.standard.removeObject(forKey: "uid")
        print("Signed out \(k)")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        self.dismiss(animated: false, completion: nil)
        //performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
 */
    
}

