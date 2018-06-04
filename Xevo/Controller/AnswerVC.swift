//
//  AnswerVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 25/05/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class AnswerVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    var seconds = 60
    var minutes = 29
    var timer = Timer()
    var isTimerRunning = false
    var placeholderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isTimerRunning == false {
            runTimer()
        }

        //textView.layer.borderWidth = 0
        //textView.layer.borderColor =
        textView.delegate = self
        textView.text = ""
        textView.text = "Start Answering"
        textView.layer.cornerRadius = 7
        textView.layer.borderColor =  UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
        textView.layer.borderWidth = 1
        //textView.delegate = self
        textView.textColor = UIColor.lightGray
        placeholderLabel = UILabel()
        placeholderLabel.text = "Enter your bio"
        placeholderLabel.font = UIFont(name: "Avenir Book", size: 16)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textView.text.isEmpty
        
        // Do any additional setup after loading the view.
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(AnswerVC.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        //pauseButton.isEnabled = true
    }
    
    
    @objc func updateTimer() {
        if seconds < 1 {
            //timer.invalidate()
            //Send alert to indicate time's up.
            minutes -= 1
            seconds = 59
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timerLabel.text = String(minutes) + ":" + String(seconds)
        } else if seconds < 10 {
            
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timerLabel.text = String(minutes) + ":0" + String(seconds)
            
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timerLabel.text = String(minutes) + ":" + String(seconds)
            //            labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(minutes)
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
