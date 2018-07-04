//
//  FinalVC.swift
//  Xevo
//
//  Created by Aditya Saxena on 01/07/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import MobileCoreServices
import Firebase
import FirebaseDatabase

class FinalVC: UIViewController, UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var yload: UILabel!
    @IBOutlet weak var lload: UILabel!
    @IBOutlet weak var kload: UILabel!
    var i = 0
    var fName = ""
    var fBio = ""
    var fChoice = ""
    var fMotivation = ""
    var sChoice = ""
    var sMotivation = ""
    var tChoice = ""
    var tMotivation = ""
    var ffChoice = ""
    var ffMotivation = ""
    var fffChoice = ""
    var fffMotivation = ""
    var dbReference: DatabaseReference?
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let myURL = url as URL
        print("import result : /(myURL)")
        if(i == 1) {
            yload.text = "resume uploaded"
        }
        
        if (i == 2) {
            lload.text = "1 optional document uploaded"
        }
        
        if (i == 3) {
            kload.text = "1 optional document uploaded"
        }
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        dismiss(animated: true, completion: nil)
        
    }

    
    @IBAction func upload(_ sender: Any) {
        
        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: UIDocumentPickerMode.import)
        
        importMenu.delegate = self
        i = 1
        self.present(importMenu, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func gobacj(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func add1(_ sender: Any) {
        
        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: UIDocumentPickerMode.import)
        
        importMenu.delegate = self
        i = 2
        self.present(importMenu, animated: true, completion: nil)
        
    }
    
    @IBAction func add2(_ sender: Any) {
        
        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: UIDocumentPickerMode.import)
        
        importMenu.delegate = self
        i = 3
        self.present(importMenu, animated: true, completion: nil)
        
    }
    
    
    @IBAction func submit(_ sender: Any) {
        
        let question1 = ["Full Name": fName, "Bio": fBio, "Expertise1": fChoice, "Motivation1": fMotivation, "Expertise2": sChoice, "Motivation2": sMotivation, "Expertise3": tChoice, "Motivation3": tMotivation, "Expertise4": ffChoice, "Motivation4": ffMotivation, "Expertise5": fffChoice, "Motivation5": fffMotivation]
        
        let id = Auth.auth().currentUser?.uid
        
        dbReference = Database.database().reference()
        dbReference?.child("Applied").child(id!).setValue(question1)
        
        dbReference?.child("Users").child(id!).child("isConsultant").setValue("Applied")
        
        print(fName)
        print(fBio)
        print(sChoice)
        print(sMotivation)
        print(fffChoice)
        print(fffMotivation)
        print(fChoice)
        
        performSegue(withIdentifier: "gootbc", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
