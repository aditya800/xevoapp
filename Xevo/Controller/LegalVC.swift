//
//  LegalVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 05/08/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class LegalVC: UIViewController {
    
    var m = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "gototermi" {
                let sc = segue.destination as! TermsVC
                sc.f = m
            }
    }
    
    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func goto(_ sender: Any) {
        m = 0
        performSegue(withIdentifier: "gototermi", sender: nil)
    }
    
    @IBAction func privatr(_ sender: Any) {
        m = 1
        performSegue(withIdentifier: "gototermi", sender: nil)
    }
    
    @IBAction func betatd(_ sender: Any) {
        m = 2
        performSegue(withIdentifier: "gototermi", sender: nil)
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
