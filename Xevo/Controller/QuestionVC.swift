//
//  QuestionVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 28/04/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {
    
    var text = "error"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goTo(_ sender: Any) {
        text = "Quick Hit"
        performSegue(withIdentifier: "goToActual", sender: self)
    }
    
    @IBAction func goToDeep(_ sender: Any) {
        text = "Deep Dive"
        performSegue(withIdentifier: "goToActual", sender: self)
    }
    
    
    @IBAction func goToHeavy(_ sender: Any) {
        text = "Heavy Lift"
        performSegue(withIdentifier: "goToActual", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sc = segue.destination as! ActualVC
        sc.tempVal = text
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
