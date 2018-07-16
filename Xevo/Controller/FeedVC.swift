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
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseDatabase

let temp = ["Test Question", "Test Question 2", "Nothing", "Whatever", "Here you go"]
let temp2 = ["Test question detail", "dddddd", "whatever", "unanswered", "This is nothing"]
var myIndex = 0

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menuCheckr = true
    var tempVal: String!
    var userId: String!
    var ref: DatabaseReference!
    
   // @IBOutlet weak var hid1: UIImageView!
    @IBOutlet weak var hid2: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imgmain: UIImageView!
    
    @IBOutlet weak var mainName: UILabel!
    
   // @IBOutlet weak var mainLbl: UIButton!
    
   // @IBAction func gotod(_ sender: Any) {
   // }
    
    @IBOutlet weak var detailLbl: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBAction func gobackv(_ sender: Any) {
        performSegue(withIdentifier: "gotobav", sender: nil)
    }
    
    @IBAction func goforward(_ sender: Any) {
        performSegue(withIdentifier: "gotote", sender: nil)
    }
    
    //@IBOutlet weak var imgMain: UIImageView!
    
    //@IBOutlet weak var leadingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgmain.layer.cornerRadius = imgmain.frame.size.width / 2
        imgmain.clipsToBounds = true
        
        // Do any additional setup after loading the view.
       // leadingConstraint.constant = -270
        //labelName.text = tempVal
        //imgMain.layer.cornerRadius = imgMain.frame.size.width / 2
        //imgMain.clipsToBounds = true
       // imgMain.layer.backgroundColor = UIColor(red: 186/255, green: 33/255, blue: 6/255, alpha: 1.0).cgColor
        //imgMain.layer.borderWidth = 1
        
       /* if(FBSDKAccessToken.current() != nil) {
            
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
        */
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let id = user?.uid
        
        self.tableView.separatorStyle = .none
        
        var fn: String!
        var sn: String!
        
        ref.child("Users").child(id!).child("firstName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            fn = snapshot.value as? String
            print(fn!)
            
            self.ref.child("Users").child(id!).child("lastName").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                
                sn = snapshot.value as? String
                print(sn!)
                
                self.mainName.text = fn!.capitalized + " " + sn!.capitalized
                
            })
            
        })
        
        if(FBSDKAccessToken.current() != nil) {
            
            print(FBSDKAccessToken.current().permissions)
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            let connection = FBSDKGraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String : AnyObject]
                
                //   self.label.text = data["name"] as? String
                
                let FBid = data["id"] as? String
                
                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                self.imgmain.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
            })
            connection.start()
        }
        
       // if let user = user {
           // let name = user.displayName
         //   labelName.text = name
       // }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        questions.removeAll()
        
        let uid = user?.uid
        
        ref.child("Questions").child(uid!).observe(.childAdded, with: {
                snapshot in
            
            let snapshotValue = snapshot.value as? NSDictionary
            let main = snapshotValue?["title"] as? String
            let detail = snapshotValue?["description"] as? String
            let has = snapshotValue?["hasAnswered"] as? String
            
            questions.insert(questionStruct(main: main, detail: detail, has: has), at: 0)
            self.tableView.reloadData()
            
        })

  /*ref.child("Questions").child("OOUN4i80LvR1bGVa2ejm56u6SnE2").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
    
    let snapshotValue = snapshot.value as? NSDictionary
    let main = snapshotValue?["title"] as? String
    let detail = snapshotValue?["description"] as? String
    
    self.questions.insert(questionStruct(main: main, detail: detail), at: 0)
    self.tableView.reloadData()
    
    
        })
     */
        
      //self.tableView.reloadData()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeaction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func swipeaction(swipe: UISwipeGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*@IBAction func showView(_ sender: Any) {
       // hid1.isHidden = !hid1.isHidden
       // hid2.isHidden = !hid2.isHidden
        if(menuCheckr) {
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            hid1.isHidden = !hid1.isHidden
            hid2.isHidden = !hid2.isHidden
            tableView.isHidden = !tableView.isHidden
        } else {
            leadingConstraint.constant = -270
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            hid1.isHidden = !hid1.isHidden
            hid2.isHidden = !hid2.isHidden
            tableView.isHidden = !tableView.isHidden
        }
        
        menuCheckr = !menuCheckr
    }
    
    @IBAction func MyCases(_ sender: Any) {
    }
    
    
    @IBAction func gotoQuestion(_ sender: Any) {
        performSegue(withIdentifier: "gotoquestion", sender: nil)
    }
    
    @IBAction func answerACase(_ sender: Any) {
        performSegue(withIdentifier: "gotoconsult", sender: nil)
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
        
        self.dismiss(animated: false, completion: nil)
        //performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celli", for: indexPath) as! customCell
        
        //cell.textLabel?.text = questions[indexPath.row].title
        
        
          cell.mainBtn.setTitle(questions[indexPath.row].main , for: .normal )
          cell.detailLbl.text = questions[indexPath.row].detail
        
        //let label2 = cell.viewWithTag(2) as! UILabel
       // label2.text = questions[indexPath.row].detail
        
       
            
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 85
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        performSegue(withIdentifier: "gotote", sender: self)
        
    }

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
    


