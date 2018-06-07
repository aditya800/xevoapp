//
//  SubcaseVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 18/05/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class SubcaseVC: UIViewController {

    @IBOutlet weak var mainbtn: UIButton!
    
    @IBOutlet weak var maintext: UITextView!
    
    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if question hasn't been answered, mainbtn.isHidden = true
        
        mainbtn.setTitle(questions[myIndex].main, for: .normal)
        maintext.text = questions[myIndex].detail
        
        let tem = questions[myIndex].has!
        if tem == "none" {
            rateout.setTitle("Awaiting Response", for: .normal)
            rateout.isEnabled = false
        }

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var rateout: UIButton!
    
    @IBAction func gotorate(_ sender: Any) {
        performSegue(withIdentifier: "gotorate", sender: nil)
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
