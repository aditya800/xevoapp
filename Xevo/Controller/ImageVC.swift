//
//  ImageVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 14/09/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import Firebase

class ImageVC: UIViewController {

    @IBOutlet weak var mainiMage: UIImageView!
    
    @IBOutlet weak var maintExt: UILabel!
    
    var qid = ""
    var fh: String?
    var tsitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let databaseRef = Database.database().reference()
        let id = Auth.auth().currentUser?.uid
        
databaseRef.child("Questions").child(id!).child(qid).child("downloadPath").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in

    self.fh = snapshot.value as? String
    //let url = URL(string: self.fh!)
    print(self.fh)

        })
        
        databaseRef.child("Questions").child(id!).child(qid).child("title").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in

            self.tsitle = (snapshot.value as? String)!
            self.maintExt.text = self.tsitle
        })
        
        print(id!)
        print(qid)
        //print(tsitle)
        
        //maintExt.text = tsitle
        //let url = URL(string: fh)
        //let data = try? Data(contentsOf: url!)
        //mainiMage.image = UIImage(data: data!)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goback(_ sender: Any) {
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
