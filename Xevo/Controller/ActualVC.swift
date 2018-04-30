//
//  ActualVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 29/04/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ActualVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var dbReference: DatabaseReference?
    
    @IBOutlet weak var labelMain: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var tempVal: String!
    
    let optionss = ["Computer Science", "Culinary", "Math", "Physics"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        labelMain.text = tempVal
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return optionss[row]
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return optionss.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TODO
    }
    
    @IBAction func submit(_ sender: Any) {
        
        let question = ["caseType": "HEAVY_LIFT", "description": "Whatever", "title": "Whatever"]
        dbReference = Database.database().reference()
        dbReference?.child("Questions").childByAutoId().setValue(question)
     
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
