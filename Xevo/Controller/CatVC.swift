//
//  CatVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 03/05/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

struct question {
    let main : String!
    let detail : String!
}

class CatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dbHandle: DatabaseHandle?
    let questions = [question]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let button1 = cell?.viewWithTag(1) as! UIButton
        button1.setTitle(questions[indexPath.row].main, for: .normal)
        
        return cell!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dbReference = Database.database().reference()
     //   dbReference.child("Cases").queryOrderedByKey().observe(.childAdded, with: {
       //     snapshot in
            
         //      let subject = snapshot.value!["subject"] as! String
            
            
       // })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
