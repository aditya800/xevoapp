//
//  CasesVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 24/05/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper
import FBSDKLoginKit
import FBSDKCoreKit

//struct DetailStruct {
//      let main : String!
//      let detail : String!
//      let rating: String!
//}

class ConsultCasesVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var list = ["red", "blue", "green"]
    
    var ref: DatabaseReference!
    
    var total = 0
    
    var count = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var avgRating: UILabel!
    
    @IBOutlet weak var imgMain: UIImageView!
    //    @IBAction func handleSelection(_ sender: Any) {
//        cityButtons.forEach { (button) in
//            UIView.animate(withDuration: 0.3, animations: {
//                button.isHidden = !button.isHidden
//                button.layer.borderColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0).cgColor
//                button.layer.borderWidth = 0.3
//                self.tableView.isHidden = !self.tableView.isHidden
//                self.view.layoutIfNeeded()
//            })
//        }
//    }
//
//    @IBAction func cityTapped(_ sender: UIButton) {
//    }
//
//    @IBOutlet var cityButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  textBox.delegate = self
        
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
       // let user = Auth.auth().currentUser
        
        self.tableView.separatorStyle = .none
        
        // if let user = user {
        // let name = user.displayName
        //   labelName.text = name
        // }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let uid = "OOUN4i80LvR1bGVa2ejm56u6SnE2"
       // print("description", uid.description)
        
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

        ref.child("Answers").child(uid).observe(.childAdded, with: {
            snapshot in
            
            let snapshotValue = snapshot.value as? NSDictionary
            let main = snapshotValue?["title"] as? String
            let detail = snapshotValue?["description"] as? String
            let rating = snapshotValue?["rating"] as? Int
        //    let count = Int(snapshot.childrenCount)
         //   self.total = self.total + rating!
           // print("total", self.total)
            

            details.insert(DetailStruct(main: main, detail: detail, rating: rating), at: 0)
            self.tableView.reloadData()
            
          //  print("COUNTT", count)
            
        })
        ref.child("Users").child(uid).child("rating").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let fn = snapshot.value as? String
            print("FN", fn)
            self.avgRating.text = fn! + "/5"
        })
        
        
//        ref.child("Answers").observe(.childAdded, with: {
//            snapshot in
//
//            let snapshotValue = snapshot.value as? NSDictionary
//            let count = Int(snapshot.childrenCount)
//            print("total1", self.total)
//            print("COUNTT", count)
//
//        })
      //  avgRating.text = String(total / count) + "/5"
       // let id = Auth.auth().currentUser?.uid
       // print("ID", id)
        
        let databaseRef = Database.database().reference()
        
        var fn: String!
        var sn: String!
        databaseRef.child("Users").child(uid).child("firstName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            fn = snapshot.value as? String
            print("firstname", fn!)
            
            
            databaseRef.child("Users").child(uid).child("lastName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                
                sn = snapshot.value as? String
                print(sn!)
                
                self.name.text = fn!.capitalized + "" + sn!.capitalized
              //  self.name.text = "ashrita"
                
            })
            
        })
        //print("TOTAL", total)
        //print("COUNT", count)
        //let avg = Double(total/count)
        //print("AVERAGE", avg)
       // avgRating.text = String(avg) + "/5"
//        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeaction(swipe:)))
//        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
//        self.view.addGestureRecognizer(rightSwipe)
        
    }
    
//    @objc func swipeaction(swipe: UISwipeGestureRecognizer) {
//        self.dismiss(animated: false, completion: nil)
//    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("detail count", details.count)
        return details.count
    }
    
//    @IBAction func buttonPressed(_ sender: Any) {
//        performSegue(withIdentifier: "goToQuestion", sender: self)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 105
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "thirdcustomcell", for: indexPath) as! thirdcustomcell
        
        //cell.textLabel?.text = questions[indexPath.row].title
        
        cell.labelMain.setTitle(details[indexPath.row].main , for: .normal )
        cell.detailLabel.text = details[indexPath.row].detail
        cell.rating.text = String(details[indexPath.row].rating) + "/5"
        
        
        //let label2 = cell.viewWithTag(2) as! UILabel
        // label2.text = questions[indexPath.row].detail
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        performSegue(withIdentifier: "goQuestion", sender: self)
       // performSegue(withIdentifier: "gotoanswer", sender: self)

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
