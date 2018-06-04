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

struct DetailStruct {
    let main : String!
    let detail : String!
}

var details = [DetailStruct]()

class CasesVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var list = ["red", "blue", "green"]
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func handleSelection(_ sender: Any) {
        cityButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                button.layer.borderColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0).cgColor
                button.layer.borderWidth = 0.3
                self.tableView.isHidden = !self.tableView.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func cityTapped(_ sender: UIButton) {
    }
    
    @IBOutlet var cityButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  textBox.delegate = self
        
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        
        self.tableView.separatorStyle = .none
        
        // if let user = user {
        // let name = user.displayName
        //   labelName.text = name
        // }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let uid = "OOUN4i80LvR1bGVa2ejm56u6SnE2"
        
        ref.child("CasesBySubject").child("computer_science").observe(.childAdded, with: {
            snapshot in
            
            let snapshotValue = snapshot.value as? NSDictionary
            let main = snapshotValue?["title"] as? String
            let detail = snapshotValue?["description"] as? String
            
            details.insert(DetailStruct(main: main, detail: detail), at: 0)
            self.tableView.reloadData()
            
            
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 105
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celli", for: indexPath) as! secondcustomcell
        
        //cell.textLabel?.text = questions[indexPath.row].title
            
            cell.labelMain.setTitle(details[indexPath.row].main , for: .normal )
            cell.detailLbl.text = details[indexPath.row].detail
            
            //let label2 = cell.viewWithTag(2) as! UILabel
            // label2.text = questions[indexPath.row].detail
      
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         myIndex = indexPath.row
         performSegue(withIdentifier: "gotoanswer", sender: self)
        
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
