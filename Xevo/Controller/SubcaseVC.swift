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
        
        mainbtn.setTitle(questions[myIndex].main, for: .normal)
        maintext.text = questions[myIndex].detail

        // Do any additional setup after loading the view.
    }
    
    
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
