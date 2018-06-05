//
//  RatingCompleteVC.swift
//  Xevo
//
//  Created by Ashrita Raman on 6/5/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class RatingCompleteVC: UIViewController {
    
    @IBOutlet weak var goToHome: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
        
        performSegue(withIdentifier: "backtohome", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
