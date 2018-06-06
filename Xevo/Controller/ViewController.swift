//
//  ViewController.swift
//  Xevo
//
//  Created by Aditya Saxena on 05/06/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sideMenuViewController = LtemVC()
    var isMenuOpened:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuViewController = storyboard!.instantiateViewController(withIdentifier: "LtemVC") as! LtemVC
        sideMenuViewController.view.frame = CGRect(x: 0, y: 80, width: 280, height: self.view.frame.height)
     //   sideMenuViewController.view.frame.height =
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func temp(_ sender: Any) {
        
        if(isMenuOpened){
            
            isMenuOpened = false
            sideMenuViewController.willMove(toParentViewController: nil)
            sideMenuViewController.view.removeFromSuperview()
            sideMenuViewController.removeFromParentViewController()
            
        }
            
        else{
            
            isMenuOpened = true
            self.addChildViewController(sideMenuViewController)
            self.view.addSubview(sideMenuViewController.view)
            sideMenuViewController.didMove(toParentViewController: self)
        }

        
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
