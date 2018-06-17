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
import SearchTextField

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ActualVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate, UITextFieldDelegate {
    
    var dbReference: DatabaseReference?
    
    var placeholderLabel : UILabel!
    
    @IBOutlet weak var category: SearchTextField!
    
    @IBOutlet weak var labelMain: UILabel!
    
    @IBOutlet weak var questionDifficult: UILabel!
    
    @IBOutlet weak var whatsup: UITextField!
    
    @IBOutlet weak var first: UITextField!
    
    @IBOutlet weak var second: UITextField!
    
    @IBOutlet weak var third: UITextField!
    
    @IBOutlet weak var fourth: UITextField!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet  var questionDiffConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var fourthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var categoryConstraint: NSLayoutConstraint!
    
    @IBAction func gobv(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func camera(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }

    var tempVal: String!
    var whichquestion: Int!
    
    let optionss = ["Agriculture", "Agricultural Technology","Astronomy and Astrophysics", "Chemical Engineering", "Chemistry", "Computer Science", "Culinary", "Math", "Physics"]
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // pickerView.delegate = self
        labelMain.text = tempVal
    
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        //textView.delegate = self
       // textView.text = ""
        // textView.text = "Bio (Ex:- Sophomore at Stanford with 2 years of work experience at Airbnb)"
        //textView.layer.cornerRadius = 7
        //textView.layer.borderColor =  UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
        //textView.layer.borderWidth = 1
        // textView.delegate = self
        //textView.textColor = UIColor.lightGray
        
       // placeholderLabel = UILabel()
       // placeholderLabel.text = "Short Description (Optional)"
       // placeholderLabel.font = UIFont(name: "Avenir Book", size: 16)
       // placeholderLabel.sizeToFit()
        //textView.addSubview(placeholderLabel)
       // placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
       // placeholderLabel.textColor = UIColor.lightGray
       // placeholderLabel.isHidden = !textView.text.isEmpty
        
        
        whatsup.setBottomBorder()
        first.setBottomBorder()
        second.setBottomBorder()
        third.setBottomBorder()
        fourth.setBottomBorder()
        category.setBottomBorder()
        
      //  let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136: //iphone 5/5s/5c
                questionDifficult.isHidden = true
                fourth.isHidden = true
          
            default:
                break
            }
        }
//        if (whichquestion == 1) { //fourth-textview. questionDiff-label
//            questionDiffConstraint.constant = 0
//            fourthConstraint.constant = 0
           // fourthConstraint.isActive = false
//            fourth.removeFromSuperview()
//            questionDifficult.removeFromSuperview()
//            self.categoryConstraint.constant = self.categoryConstraint.constant + 300;
//            self.fourthConstraint.constant = self.fourthConstraint.constant + 250;
            //fourth.isHidden = true
            
         //   questionDifficult.isHidden = true
            //questionDiffConstraint.isActive = false
            //fourthConstraint.isActive = false
            
          //  self.toChangeConstraint.constant = -20;
        //}
        
        category.filterStrings(["Architecture", "Architecture/Architectural Engineering",
                                "Interior Design", "Accounting", "Business Honors Program",
                                "Finance", "International Business", "Management", "Management Information Systems", "Marketing", "Science and Technology Management", "Supply Chain Management", "Advertising",
                                "Communication and Leadership", "Communication Studies", "Corporate Communication", "Human Relations", "Political Communication", "Communication Sciences and Disorders",
                                "Audiology", "Education of the Deaf/Hearing Impaired", "Speech/Language Pathology", "Journalism", "Public Relations", "Radio-Television-Film", "Applied Movement Science", "Health Promotion", "Physical Culture and Sports", "Sport Management", "Aerospace Engineering", "Architectural Engineering", "Biomedical Engineering", "Chemical Engineering", "Civil Engineering", "Computational Engineering", "Electrical and Computer Engineering", "Environmental Engineering", "Geosystems Engineering and Hydrogeology", "Mechanical Engineering", "Petroleum Engineering", "Acting", "Art History", "Arts and Entertainment Technologies", "Dance", "Dance Studies", "Design", "Jazz", "Music", "Music Composition", "Music Performance", "Music Studies", "Choral Music Emphasis", "Instrumental Emphasis", "Studio Art", "Theatre and Dance", "Theatre Studies", "Visual Art Studies", "Environmental Sciences", "Geological Sciences", "Pharmacy", "Nursing", "Chemistry", "Biology", "Computer Science", "Astronomy", "Biochemistry", "Teaching", "BSA", "Human Development", "Families and Society", "Mathematics", "Physics", "Textiles and Apparel", "Consumer Science", "African and African Diaspora Studies", "American Studies", "Anthropology", "Chinese", "Hindi/Urdu", "Japanese", "Korean", "Malayalam", "Sanskrit", "Tamil", "Greek", "Latin", "Classical Studies", "Ancient History", "Classical Archaeology", "Economics", "English", "Ethnic Studies", "Asian American", "Mexican American", "European Studies", "French", "Geography", "German", "Government", "Health and Society", "History", "Human Dimensions of Organizations", "Humanities", "Iberian and Latin American Languages and Cultures", "International Relations and Global Studies", "Islamic Studies", "Italian", "Jewish Studies", "Latin American Studies", "Linguistics", "Middle Eastern Languages and Cultures", "Middle Eastern Studies", "Philosophy", "Psychology", "Religious Studies", "Rhetoric and Writing", "Russian, East European and Eurasian Studies", "Sociology", "Sustainability Studies", "Culinary", "Styling" ])
        
        // Do any additional setup after loading the view.
        
        if(labelMain.text == "Quick Hit") {
            questionDifficult.isHidden = true
            fourth.isHidden = true
        }
        first.delegate = self
        second.delegate = self
        third.delegate = self
        
        first.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        second.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        third.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)

    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      //  print("test???")
        let maxLength = 56
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if (text?.utf16.count)! >= 56{
            switch textField{
            case first:
                third.becomeFirstResponder()
            case third:
                second.becomeFirstResponder()
            case second:
                second.resignFirstResponder()
            default:
                break
            }
        }else{
            
        }
    }
    
//    extension ActualVC: UITextFieldDelegate{
//        func textFieldDidBeginEditing(textField: UITextField) {
//            textField.text = ""
//        }
//    }
 
    
    @IBAction func submit(_ sender: Any) {
        
        if(whatsup.text == "") {
            whatsup.layer.borderColor =  UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
        } else {
        
        countc += 1
        mainc = countc
        //a  = true
            
        let id = Auth.auth().currentUser?.uid
            let desc = first.text! + second.text! + third.text!
            let username = Auth.auth().currentUser?.uid
            let question1 = ["caseType": labelMain.text!, "description": desc, "title": whatsup.text!, "hasAnswered": "none", "reasonForDifficulty": fourth.text!] as [String : Any]
        dbReference = Database.database().reference()
        dbReference?.child("Questions").child(id!).childByAutoId().setValue(question1)
            
            let image = mainImage.image
            
            if image != nil {
            self.uploadProfileImage(image!) { url in
                
                if url != nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                   // changeRequest?.displayName = username
                    changeRequest?.photoURL = url
                    
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            print("User display name changed!")
                            
                        } else {
                            print("Error: \(error!.localizedDescription)")
                        }
                    }
                } else {
                    // Error unable to upload profile image
                    print("Error")
                }
                
            }
            }
            
            dbReference?.child("Users").child(id!).child("cases").setValue("yes")
            
            let alertController = UIAlertController(title: "Submit",
                                                    message: "Are you sure you want to submit this question?", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                self.performSegue(withIdentifier: "gototemp", sender: nil)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                self.dismiss(animated: false, completion: nil)
                
            }
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        //performSegue(withIdentifier: "gototemp", sender: nil)
        
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @objc func openImagePicker(_ sender:Any) {
        // Open Image Picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                if let url = metaData?.downloadURL() {
                    completion(url)
                } else {
                    completion(nil)
                }
                // success!
            } else {
                // failed
                completion(nil)
            }
        }
    }

}

extension ActualVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.mainImage.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
}
    
    

}
