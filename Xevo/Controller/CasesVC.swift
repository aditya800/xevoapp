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
    let rating : Int!
}

var details = [DetailStruct]()

class CasesVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var list = ["red", "blue", "green"]
    var sideMenuViewController = MtemVC()
    var isMenuOpened:Bool = false
    var ref: DatabaseReference!
    var vsideMenuViewController = LtemVC()
    var visMenuOpened:Bool = false
    var statusBarHidden = false
    //var cba = ""
    //var flag = 0
    
    @IBOutlet weak var vshowside: UIButton!
    
    @IBAction func showside(_ sender: Any) {
        
        
        if(visMenuOpened){
            
            
            
            //   transition.subtype = kCATransitionFromRight
            // sideMenuViewController.view.layer.add(transition, forKey: kCATransition)
            
            visMenuOpened = false
            vshowside.setImage(#imageLiteral(resourceName: "Hamburger_icon.svg"), for: .normal)
            vsideMenuViewController.willMove(toParentViewController: nil)
            vsideMenuViewController.view.removeFromSuperview()
            vsideMenuViewController.removeFromParentViewController()
        }
            
        else {
            
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
            
            
            vsideMenuViewController.view.layer.add(transition, forKey: kCATransition)
            // sideMenuViewController.navigationController?.pushViewController(ltemvc, animated: false)
            
            //view.window!.layer.add(transition, forKey: kCATransition)
            // present(ltemvc, animated: false, completion: nil)
            
            
            //   sideMenuViewController.view.clipsToBounds = true
            
            
            
            visMenuOpened = true
            vshowside.setImage(#imageLiteral(resourceName: "close_symbol"), for: .normal)
            self.addChildViewController(vsideMenuViewController)
            self.view.addSubview(vsideMenuViewController.view)
            vsideMenuViewController.didMove(toParentViewController: self)
        }

        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func toggak(_ sender: Any) {
        if(isMenuOpened){
            //   transition.subtype = kCATransitionFromRight
            // sideMenuViewController.view.layer.add(transition, forKey: kCATransition)
            
            isMenuOpened = false
            // showside.setImage(#imageLiteral(resourceName: "Hamburger_icon.svg"), for: .normal)
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
            
            
            // sideMenuViewController.view.layer.add(transition, forKey: kCATransition)
            // sideMenuViewController.navigationController?.pushViewController(ltemvc, animated: false)
            
            //view.window!.layer.add(transition, forKey: kCATransition)
            // present(ltemvc, animated: false, completion: nil)
            
            
            //   sideMenuViewController.view.clipsToBounds = true
            
            isMenuOpened = true
            //showside.setImage(#imageLiteral(resourceName: "close_symbol"), for: .normal)
            self.addChildViewController(sideMenuViewController)
            self.view.addSubview(sideMenuViewController.view)
            sideMenuViewController.didMove(toParentViewController: self)
        }
    }
    
    @IBOutlet weak var handleselect: UIButton!
    
    @IBAction func handleSelection(_ sender: Any) {
        
    }
    
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
        
        let uid = user?.uid
        
        ref.child("CasesBySubject").child("computer_science").observe(.childAdded, with: {
            snapshot in
            
            let snapshotValue = snapshot.value as? NSDictionary
            let main = snapshotValue?["title"] as? String
            let detail = snapshotValue?["description"] as? String
            let rating = snapshotValue?["rating"] as? Int
            // let exp1 = snapshotValue?["exp1"] as? String
            
            details.insert(DetailStruct(main: main, detail: detail, rating: rating), at: 0)
            self.tableView.reloadData()
            
        })
        
        ref.child("Users").child(uid!).child("exp1").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let temp = snapshot.value as? String
            self.handleselect.setTitle(temp?.capitalized, for: .normal)
            
            // self.handleselect.setTitle(self.cba.capitalized, for: .normal)
            
        })
        
        sideMenuViewController = storyboard!.instantiateViewController(withIdentifier: "MtemVC") as! MtemVC
        sideMenuViewController.view.frame = CGRect(x: 83, y: 185, width: 250, height: 210)
        
        vsideMenuViewController = storyboard!.instantiateViewController(withIdentifier: "LtemVC") as! LtemVC
        vsideMenuViewController.view.frame = CGRect(x: 0, y: 0, width: 280, height: self.view.frame.height)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        area = CGRect(x: 0, y: 0, width: 280, height: self.view.frame.height)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        visMenuOpened = false
        vshowside.setImage(#imageLiteral(resourceName: "Hamburger_icon.svg"), for: .normal)
        vsideMenuViewController.willMove(toParentViewController: nil)
        vsideMenuViewController.view.removeFromSuperview()
        vsideMenuViewController.removeFromParentViewController()
        
        let p = sender.location(in: self.view)
        if area!.contains(p) {
            isMenuOpened = true
        }
        else {
            isMenuOpened = false
            //showside.setImage(#imageLiteral(resourceName: "Hamburger_icon.svg"), for: .normal)
            sideMenuViewController.willMove(toParentViewController: nil)
            sideMenuViewController.view.removeFromSuperview()
            sideMenuViewController.removeFromParentViewController()
            self.statusBarHidden = false
            setNeedsStatusBarAppearanceUpdate()
        }
        
    }
    
     override var prefersStatusBarHidden: Bool {
        return self.statusBarHidden
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
        performSegue(withIdentifier: "fotofeed", sender: self)
        
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

