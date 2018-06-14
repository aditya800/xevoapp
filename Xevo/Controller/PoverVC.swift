//
//  PoverVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 13/06/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class PoverVC: UIViewController {
    
    var read = 0
    
    @IBOutlet weak var gonext: UIButton!
    
    @IBOutlet weak var mainText: UITextView!
    
    @IBOutlet weak var viewmain: UIView!
    
    @IBAction func next(_ sender: Any) {
        if read == 0 {
            mainText.text = "To see all your asked questions, navigate to your cases by tapping the hamburger button on the top left and selecting \"My Cases\". You can then select any particular case to check its details."
            
            read += 1
            
        } else if read == 1 {
            mainText.text = "For submitting your consultant application for review, navigate to this option by tapping the hamburger button again on the top left and selecting \"Become a consultant\" and answer the questions asked."
            
            read += 1
            
        } else if read == 2{
            
            gonext.setTitle("Finish", for: .normal)
            
            mainText.text = "You are all set to use the Xevo app. Enjoy your experience!"
            
            read += 1
            
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func skip(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewmain.layer.borderColor = UIColor.lightGray.cgColor
        viewmain.layer.borderWidth = 0.5
        viewmain.layer.cornerRadius = 18
        
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
