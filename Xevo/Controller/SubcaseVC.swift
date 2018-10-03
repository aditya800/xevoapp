//
//  SubcaseVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 18/05/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import Firebase

class SubcaseVC: UIViewController {

    @IBOutlet weak var mainbtn: UIButton!
    
    @IBOutlet weak var maintext: UITextView!
    
    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    let temp = questions[myIndex].qid
    
    @IBAction func toimage(_ sender: Any) {
        performSegue(withIdentifier: "gotovimage", sender: nil)
    }
    
    @IBOutlet weak var tohimage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        mainbtn.setTitle(questions[myIndex].main, for: .normal)
        maintext.text = questions[myIndex].detail
        
        let tem = questions[myIndex].has!
        if tem == "none" {
            rateout.setTitle("Awaiting Response", for: .normal)
            rateout.isEnabled = false
        }

        var fn = ""
        let databaseRef = Database.database().reference()
        let id = Auth.auth().currentUser?.uid
        databaseRef.child("Questions").child(id!).child(temp!).child("hasImage").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            fn = (snapshot.value as? String)!
            
        })
        
        if(fn == "no") {
            tohimage.isHidden = true
        }
        
        print(temp!)
        print(temp!)
        
        // Do any additional setup after loading the view.
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeaction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func swipeaction(swipe: UISwipeGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var rateout: UIButton!
    
    @IBAction func gotorate(_ sender: Any) {
        performSegue(withIdentifier: "gotorate", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotovimage" {
            let sc = segue.destination as! ImageVC
            sc.qid = temp!
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
