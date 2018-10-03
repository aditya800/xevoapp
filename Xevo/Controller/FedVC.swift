//
//  FedVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 16/07/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FBSDKCoreKit
import FBSDKLoginKit

class FedVC: UIViewController {

    var ref: DatabaseReference!
    var f = 0
    
    @IBOutlet weak var firstline: UILabel!
    @IBOutlet weak var secondline: UILabel!
    @IBOutlet weak var payment: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgMain.layer.cornerRadius = imgMain.frame.size.width / 2
        imgMain.clipsToBounds = true
        
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let id = user?.uid
        
        //self.tableView.separatorStyle = .none
        
        var fn: String!
        var sn: String!
        
        ref.child("Users").child(id!).child("firstName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            fn = snapshot.value as? String
            print(fn!)
            
            self.ref.child("Users").child(id!).child("lastName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                
                sn = snapshot.value as? String
                print(sn!)
                
                self.mainT.text = fn!.capitalized + " " + sn!.capitalized
                
            })
            
        })
        
        if(f==4) {
            payment.setTitle("My Payments", for: .normal)
        }
        
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
        
        if(f == 2) {
            firstline.text = "You do not have any cases yet. Answer a "
        }
        
        if(f==4) {
            firstline.text = "You have not made any payments yet. Payments"
        }
        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var mainT: UILabel!
    @IBOutlet weak var imgMain: UIImageView!
    
    @IBAction func gobak(_ sender: Any) {
        dismiss(animated: false, completion: nil)
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
