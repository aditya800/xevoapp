//
//  ltemVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 05/06/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import SideMenu
import Firebase
import SwiftKeychainWrapper
import FBSDKLoginKit
import FBSDKCoreKit

class LtemVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgMain.layer.cornerRadius = imgMain.frame.size.width / 2
        imgMain.clipsToBounds = true
        imgMain.layer.backgroundColor = UIColor(red: 186/255, green: 33/255, blue: 6/255, alpha: 1.0).cgColor
        imgMain.layer.borderWidth = 1
        
        if(FBSDKAccessToken.current() != nil) {
            
            print(FBSDKAccessToken.current().permissions)
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            let connection = FBSDKGraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String : AnyObject]
                
                //   self.label.text = data["name"] as? String
                
                let FBid = data["id"] as? String
                
                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                self.imgMain.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
            })
            connection.start()
        }
        
        let id = Auth.auth().currentUser?.uid
        
        let databaseRef = Database.database().reference()
        
        var fn: String!
        var sn: String!
        
        databaseRef.child("Users").child(id!).child("firstName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            fn = snapshot.value as? String
            print(fn!)
            
            databaseRef.child("Users").child(id!).child("lastName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                
                sn = snapshot.value as? String
                print(sn!)
                
                self.lblMain.text = fn!.capitalized + " " + sn!.capitalized
                
            })
            
        })
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imgMain: UIImageView!
    
    @IBOutlet weak var lblMain: UILabel!
    
    @IBAction func myCases(_ sender: Any) {
        performSegue(withIdentifier: "gotocas", sender: nil)
    }
    
    @IBAction func askaques(_ sender: Any) {
    }
    
    @IBOutlet weak var bcomaconsul: UIButton!
    
    @IBAction func bcomeaconsult(_ sender: Any) {
    }
    
    @IBAction func logout(_ sender: Any) {
        
        let k = KeychainWrapper.standard.removeObject(forKey: "uid")
        print("Signed out \(k)")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        //self.dismiss(animated: false, completion: nil)
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
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
