//
//  QuestionVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 28/04/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper
import FBSDKCoreKit
import FBSDKLoginKit

var mainc = 0
var countc = 0
var whichquestion = 0

struct questionStruct {
    let main : String!
    let detail : String!
    let has : String!
}

var questions = [questionStruct]()

class QuestionVC: UIViewController {
    
    var sideMenuViewController = LtemVC()
    var isMenuOpened:Bool = false
    
    var text = "error"

    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* imageMain.layer.cornerRadius = imageMain.frame.size.width / 2
        imageMain.clipsToBounds = true
        imageMain.layer.backgroundColor = UIColor(red: 186/255, green: 33/255, blue: 6/255, alpha: 1.0).cgColor
        imageMain.layer.borderWidth = 1
        */
        sideView.isHidden = true
        
        /*if(FBSDKAccessToken.current() != nil) {
            
            print(FBSDKAccessToken.current().permissions)
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            let connection = FBSDKGraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String : AnyObject]
                
                //   self.label.text = data["name"] as? String
                
                let FBid = data["id"] as? String
                
                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                self.imageMain.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
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
                
                self.sideName.text = fn!.capitalized + " " + sn!.capitalized
                
            })
            
        })
        
       */
        
        //print(fn + " " + sn)
        //sideName.text = fn!.capitalized + " " + sn!.capitalized
        
        // Do any additional setup after loading the view.
        
        sideMenuViewController = storyboard!.instantiateViewController(withIdentifier: "LtemVC") as! LtemVC
        sideMenuViewController.view.frame = CGRect(x: 0, y: 80, width: 280, height: self.view.frame.height)
        
     
    }
    
    
    @IBOutlet weak var imageMain: UIImageView!
    
    @IBOutlet weak var sideName: UILabel!
    
    @IBOutlet weak var sideView: UIView!

    @IBOutlet weak var showside: UIButton!
    
    @IBOutlet weak var askAQ: UIButton!

    @IBOutlet weak var myCases: UIButton!
    
   // @IBOutlet weak var controller: FeedVC!
    
    @IBAction func AskaQ(_ sender: Any) {
        sideView.isHidden = !sideView.isHidden
        showside.setImage(#imageLiteral(resourceName: "Hamburger_icon.svg"), for: .normal)
    }
    
    @IBAction func become(_ sender: Any) {
        
        let id = Auth.auth().currentUser?.uid
        
        let databaseRef = Database.database().reference()
        
        databaseRef.child("Users").child(id!).child("isConsultant").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            if temp == "Applied" {
                self.performSegue(withIdentifier: "gotovonsultant", sender: nil)
            } else {
                self.performSegue(withIdentifier: "gotobecome", sender: nil)
            }
            
        })
    }
    
   // @IBAction func myCases(_ sender: Any) {
        //var questions = [questionStruct]()
      //  let id = Auth.auth().currentUser?.uid
        //let username = Auth.auth().currentUser?.uid
//        print("questions!", questions)
//        print("true")
//       // print("questions!", questions)
//        if (questions.isEmpty) {
//            print("true")
//            myCases.isEnabled = false
//            myCases.setTitle("My Cases (0)", for: .normal)
//        }
//        else {
//            print("segue performed")
//       // performSegue(withIdentifier: "gotocases", sender: nil)
       // }
   // }
    
    
    @IBAction func showSide(_ sender: Any) {
        
        
        if(isMenuOpened){
            
            
            
         //   transition.subtype = kCATransitionFromRight
           // sideMenuViewController.view.layer.add(transition, forKey: kCATransition)

            isMenuOpened = false
            showside.setImage(#imageLiteral(resourceName: "Hamburger_icon.svg"), for: .normal)
            sideMenuViewController.willMove(toParentViewController: nil)
            sideMenuViewController.view.removeFromSuperview()
            sideMenuViewController.removeFromParentViewController()
            
            
        }
            
        else{
            
//            let transition:CATransition = CATransition()
//            transition.duration = 0.5
//            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//            transition.type = kCATransitionPush
//            transition.subtype = kCATransitionFromBottom
//            self.navigationController!.view.layer.add(transition, forKey: kCATransition)
//            self.navigationController?.pushViewController(dstVC, animated: false)
            
            let transition = CATransition()
            //let ltemvc = LtemVC()
            //let questionvc = QuestionVC()

            let withDuration = 0.4
            transition.startProgress = 0.9;
            transition.endProgress = 1;

            transition.duration = withDuration
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionMoveIn
            transition.subtype = kCATransitionFromLeft
            
            
            sideMenuViewController.view.layer.add(transition, forKey: kCATransition)
           // sideMenuViewController.navigationController?.pushViewController(ltemvc, animated: false)
            
            //view.window!.layer.add(transition, forKey: kCATransition)
           // present(ltemvc, animated: false, completion: nil)
            
            
         //   sideMenuViewController.view.clipsToBounds = true

            
            
            isMenuOpened = true
            showside.setImage(#imageLiteral(resourceName: "close_symbol"), for: .normal)
            self.addChildViewController(sideMenuViewController)
            self.view.addSubview(sideMenuViewController.view)
            sideMenuViewController.didMove(toParentViewController: self)
        }

        
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        questions.removeAll()
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

        //performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goTo(_ sender: Any) {
        text = "Quick Hit"
        whichquestion = 0
        performSegue(withIdentifier: "goToActual", sender: self)
    }
    
    @IBAction func goToDeep(_ sender: Any) {
        text = "Deep Dive"
        whichquestion = 1
        performSegue(withIdentifier: "goToActual", sender: self)
    }
    
    
    @IBAction func goToHeavy(_ sender: Any) {
        text = "Heavy Lift"
        whichquestion = 2
        performSegue(withIdentifier: "goToActual", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToActual" {
        let sc = segue.destination as! ActualVC
        sc.tempVal = text
        }
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
