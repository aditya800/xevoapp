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
    
    @IBOutlet weak var askd: UIButton!
    @IBOutlet weak var bcomd: UIButton!
    var i = 1
    
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
        
       //let databaseRef = Database.database().reference()
        
        databaseRef.child("Users").child(id!).child("isConsultant").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            if temp == "Verified" {
                self.bcomd.setTitle("Answer a Case             ", for: .normal)
            }
            
        })
        
        var fn: String!
        var sn: String!
        
        databaseRef.child("Users").child(id!).child("firstName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            fn = snapshot.value as? String
            //print(fn!)
            
            databaseRef.child("Users").child(id!).child("lastName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                
                sn = snapshot.value as? String
                //print(sn!)
                
                self.lblMain.text = fn!.capitalized + " " + sn!.capitalized
                
            })
            
        })
        
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        
        print("questionscount1", questions.count)
        print("mainc1", mainc)
        print("countc1", countc)
        
        if(mainc == 0 || mainc != countc) {
        
        ref.child("Questions").child(uid!).observe(.childAdded, with: {
            snapshot in
            
            let snapshotValue = snapshot.value as? NSDictionary
            let main = snapshotValue?["title"] as? String
            let detail = snapshotValue?["description"] as? String
            let has = snapshotValue?["hasAnswered"] as? String
            
            questions.insert(questionStruct(main: main, detail: detail, has: has), at: 0)
            //self.tableView.reloadData()
            //self.reloadInputViews()
            
        })
            
        }
        
        
        ref.child("Users").child(id!).child("cases").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            if temp == "no" {
                //self.myCases.isEnabled = false
                //self.myCases.setTitle("My Cases (0 new)", for: .normal)
                //self.myCases.sizeToFit()
                self.i = 2
            }
            
        })
        
        //print("questionscount", questions.count)
        countc = questions.count
        mainc = countc
        //print("mainc", mainc)
        //print("countc", countc)
        
//        if (questions.count == 0) {
//            print("truldkflke")
//            myCases.isEnabled = false
//            myCases.setTitle("My Cases (0)", for: .normal)
//            myCases.sizeToFit()
//        }
    }
 
        // Do any additional setup after loading the view.
    
    
    @IBOutlet weak var imgMain: UIImageView!
    
    @IBOutlet weak var myCases: UIButton!
    
    @IBOutlet weak var lblMain: UILabel!
    
    @IBAction func myCases(_ sender: Any) {
//        if (questions.isEmpty) {
//            myCases.isEnabled = false
//            myCases.setTitle("My Cases (0)", for: .normal)
//            myCases.sizeToFit()
//        }
//        else {
        
        if(i == 2) {
            performSegue(withIdentifier: "gotofedd", sender: nil)
        } else {
        
       let id = Auth.auth().currentUser?.uid
        
       let databaseRef = Database.database().reference()
        
        databaseRef.child("Users").child(id!).child("isConsultant").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            if temp == "Verified" {
              self.performSegue(withIdentifier: "gotov", sender: nil)
            } else {
        
        self.performSegue(withIdentifier: "gotocas", sender: nil)
        print("test", questions.count)
            }
        })
        //}
      }
    }
    
    @IBAction func askaques(_ sender: Any) {
      //  self.willMove(toParentViewController: nil)
        //self.view.removeFromSuperview()
        performSegue(withIdentifier: "gotovarn", sender: nil)
       // self.removeFromParentViewController()
        
    }
    
    
    @IBOutlet weak var bcomaconsul: UIButton!
    
    @IBAction func bcomeaconsult(_ sender: Any) {
        
        let id = Auth.auth().currentUser?.uid
        
        let databaseRef = Database.database().reference()
        
        databaseRef.child("Users").child(id!).child("isConsultant").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            if temp == "Applied" {
                self.performSegue(withIdentifier: "gotovonsultante", sender: nil)
            } else if temp == "Verified" {
                self.performSegue(withIdentifier: "gotob", sender: nil)
            } else {
                self.performSegue(withIdentifier: "gotobecomee", sender: nil)
            }
            
        })
        
    }
    
    @IBAction func logout(_ sender: Any) {
        
        questions.removeAll()
        mainc = 0
        countc = 0
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


