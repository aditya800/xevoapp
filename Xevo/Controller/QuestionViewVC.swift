//
//  QuestionViewVC.swift
//  Xevo
//
//  Created by Ashrita Raman on 6/12/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class QuestionViewVC: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!

    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("INDEX", myIndex)
        mainLabel.text = details[myIndex].main
        detailLabel.text = details[myIndex].detail

        // Do any additional setup after loading the view.
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeaction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func swipeaction(swipe: UISwipeGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
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
