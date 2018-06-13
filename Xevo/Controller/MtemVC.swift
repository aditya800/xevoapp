//
//  MtemVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 12/06/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MtemVC: UIViewController {
    
    var ref: DatabaseReference!
    var tang: String!
    
    // var text = "error"
    // var flag = 0
    
    @IBOutlet weak var exp2l: UIButton!
    
    @IBOutlet weak var exp3l: UIButton!
    
    @IBOutlet weak var exp4l: UIButton!
    
    @IBOutlet weak var exp5l: UIButton!
    
    
    @IBAction func exp2(_ sender: Any) {
        // text = exp2l.currentTitle!
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let uid = user?.uid
        print(exp2l.currentTitle!)
        ref.child("Users").child(uid!).child("exp1").setValue(exp2l.currentTitle!)
        ref.child("Users").child(uid!).child("exp2").setValue(tang)
        
        performSegue(withIdentifier: "gotoyarn", sender: nil)
    }
    
    @IBAction func exp5(_ sender: Any) {
        // text = exp5l.currentTitle!
        //performSegue(withIdentifier: "gotoyarn", sender: nil)
        
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let uid = user?.uid
        ref.child("Users").child(uid!).child("exp1").setValue(exp5l.currentTitle!)
        ref.child("Users").child(uid!).child("exp5").setValue(tang)
        
        performSegue(withIdentifier: "gotoyarn", sender: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let user = Auth.auth().currentUser
        
        let uid = user?.uid
        ref = Database.database().reference()
        
        //        ref.child("Users").child(uid).observe(.childAdded, with: {
        //            snapshot in
        //
        //            let snapshotValue = snapshot.value as? NSDictionary
        //            let expr2 = snapshotValue?["exp2"] as? String
        //            let expr3 = snapshotValue?["exp3"] as? String
        //            let expr4 = snapshotValue?["exp4"] as? String
        //            let expr5 = snapshotValue?["exp5"] as? String
        //
        //            // let exp1 = snapshotValue?["exp1"] as? String
        //
        //           // self.exp2l.setTitle(expr2!, for: .normal)
        //            //self.exp3l.setTitle(expr3!, for: .normal)
        //            //self.exp4l.setTitle(expr4!, for: .normal)
        //            //self.exp5l.setTitle(expr5!, for: .normal)
        //            print(expr2!)
        //            //details.insert(DetailStruct(main: main, detail: detail), at: 0)
        //            //self.tableView.reloadData()
        //
        //        })
        
        ref.child("Users").child(uid!).child("exp1").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            print(temp!)
            self.tang = temp
            //self.ref.child("Users").child(self.uid).child("exp2").setValue(temp!)
            
        })
        
        ref.child("Users").child(uid!).child("exp2").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            self.exp2l.setTitle(temp?.capitalized, for: .normal)
            
        })
        
        ref.child("Users").child(uid!).child("exp3").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            self.exp3l.setTitle(temp?.capitalized, for: .normal)
            
        })
        
        ref.child("Users").child(uid!).child("exp4").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            self.exp4l.setTitle(temp?.capitalized, for: .normal)
            
        })
        
        ref.child("Users").child(uid!).child("exp5").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            self.exp5l.setTitle(temp?.capitalized, for: .normal)
            
        })
        
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "gotoyarn" {
     let sc = segue.destination as! CasesVC
     // sc.cba = text
     //sc.flag = 1
     }}*/
    
    @IBAction func exp3(_ sender: Any) {
        
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let uid = user?.uid
        ref.child("Users").child(uid!).child("exp1").setValue(exp3l.currentTitle!)
        ref.child("Users").child(uid!).child("exp3").setValue(tang)
        
        performSegue(withIdentifier: "gotoyarn", sender: nil)
        
    }
    
    @IBAction func exp4(_ sender: Any) {
        
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let uid = user?.uid
        ref.child("Users").child(uid!).child("exp1").setValue(exp4l.currentTitle!)
        ref.child("Users").child(uid!).child("exp4").setValue(tang)
        
        performSegue(withIdentifier: "gotoyarn", sender: nil)
        
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

