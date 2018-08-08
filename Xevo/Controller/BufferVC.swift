//
//  BufferVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 18/07/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class BufferVC: UIViewController {
    
    @IBOutlet weak var mainT: UIButton!
    @IBOutlet weak var subT: UITextView!
    
    @IBAction func continueT(_ sender: Any) {
        performSegue(withIdentifier: "fotomain", sender: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainT.setTitle(details[myIndex].main, for: .normal)
        subT.text = details[myIndex].detail
        // Do any additional setup after loading the view.
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
