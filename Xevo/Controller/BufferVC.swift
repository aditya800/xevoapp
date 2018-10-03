//
//  BufferVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 18/07/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import Firebase

class BufferVC: UIViewController {
    
    @IBOutlet weak var mainT: UIButton!
    @IBOutlet weak var subT: UITextView!
    
    @IBOutlet weak var viewimage: UIButton!
    
    @IBAction func toviewimage(_ sender: Any) {
        performSegue(withIdentifier: "gotoimage", sender: nil)
    }
    
    @IBAction func continueT(_ sender: Any) {
        
        let alert = UIAlertController(title: "Answer this question", message: "If you select to answer, you will get 30 minutes to answer this question after which the question will get locked for you.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Answer", style: UIAlertActionStyle.default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.performSegue(withIdentifier: "fotomain", sender: nil)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    let temp = details[myIndex].qid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainT.setTitle(details[myIndex].main, for: .normal)
        subT.text = details[myIndex].detail
        let databaseRef = Database.database().reference()
        let id = Auth.auth().currentUser?.uid
        var fn = ""
        databaseRef.child("Questions").child(id!).child(temp!).child("hasImage").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            fn = (snapshot.value as? String)!
            
         })
        
        databaseRef.child("Questions").child(id!).child(temp!).child("isWorking").setValue("yes")
        
        if(fn == "no") {
        viewimage.isHidden = true
        }
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotoimage" {
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
