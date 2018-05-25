//
//  TemoVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 16/05/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class TemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goback(_ sender: Any) {
        
        performSegue(withIdentifier: "gotomf", sender: nil)
        
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
