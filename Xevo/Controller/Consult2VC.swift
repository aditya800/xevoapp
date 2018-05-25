//
//  Consult2VCViewController.swift
//  Xevo
//
//  Created by Aditya Saxena on 24/05/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit
import SearchTextField

var sChoice: String!
var sMotivation: String!

class Consult2VC: UIViewController {

    
    @IBOutlet weak var firstexp: SearchTextField!
    
    @IBOutlet weak var first: UITextField!
    
    @IBOutlet weak var second: UITextField!
    
    @IBOutlet weak var third: UITextField!
    
    //@IBOutlet weak var choosebn: UIButton!
    //var count = 1
    var name: String!
    var bio: String!
    //var dbReference: DatabaseReference?
    /*
     @IBOutlet weak var Lbl1: UILabel!
     @IBOutlet weak var Lbl2: UILabel!
     @IBOutlet weak var Lbl3: UILabel!
     @IBOutlet weak var Lbl4: UILabel!
     @IBOutlet weak var Lbl5: UILabel!
     
     @IBOutlet var majorbn: [UIButton]!
     
     @IBAction func choosebtn(_ sender: Any) {
     majorbn.forEach { (majorbtn) in
     // majorbtn.layer.cornerRadius = 7
     UIView.animate(withDuration: 0.4, animations: {
     majorbtn.isHidden = !majorbtn.isHidden
     self.view.layoutIfNeeded()
     })
     }
     }
     
     @IBAction func major(_ sender: UIButton) {
     
     if let temp = sender.titleLabel?.text {
     
     print(count)
     
     
     // if(count > 5) {
     if(temp == Lbl1.text) {
     sender.layer.backgroundColor = UIColor(red: 83/255, green: 27/255, blue: 147/255, alpha: 1.0).cgColor
     Lbl1.text = ""
     count -= 1
     } else if(temp == Lbl2.text) {
     sender.layer.backgroundColor = UIColor(red: 83/255, green: 27/255, blue: 147/255, alpha: 1.0).cgColor
     Lbl2.text = ""
     count -= 1
     } else if(temp == Lbl3.text) {
     sender.layer.backgroundColor = UIColor(red: 83/255, green: 27/255, blue: 147/255, alpha: 1.0).cgColor
     Lbl3.text = ""
     count -= 1
     } else if(temp == Lbl4.text) {
     sender.layer.backgroundColor = UIColor(red: 83/255, green: 27/255, blue: 147/255, alpha: 1.0).cgColor
     Lbl4.text = ""
     count -= 1
     } else if(temp == Lbl5.text) {
     sender.layer.backgroundColor = UIColor(red: 83/255, green: 27/255, blue: 147/255, alpha: 1.0).cgColor
     Lbl5.text = ""
     count -= 1
     } else {
     switch(count) {
     case 1:
     Lbl1.text = temp
     sender.layer.backgroundColor = UIColor(red: 168/255, green: 60/255, blue: 36/255, alpha: 1.0).cgColor
     count += 1
     break
     case 2:
     Lbl2.text = temp
     sender.layer.backgroundColor = UIColor(red: 168/255, green: 60/255, blue: 36/255, alpha: 1.0).cgColor
     count += 1
     break
     case 3:
     Lbl3.text = temp
     sender.layer.backgroundColor = UIColor(red: 168/255, green: 60/255, blue: 36/255, alpha: 1.0).cgColor
     count += 1
     break
     case 4:
     Lbl4.text = temp
     sender.layer.backgroundColor = UIColor(red: 168/255, green: 60/255, blue: 36/255, alpha: 1.0).cgColor
     count += 1
     break
     case 5:
     Lbl5.text = temp
     sender.layer.backgroundColor = UIColor(red: 168/255, green: 60/255, blue: 36/255, alpha: 1.0).cgColor
     count += 1
     break
     default:
     break
     }
     }
     
     
     }
     }
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        choosebn.layer.cornerRadius = 7
        
        /*      majorbn.forEach { (majorbtn) in
         majorbtn.layer.cornerRadius = 7
         majorbtn.isHidden = true
         }
         */
        // Do any additional setup after loading the view.
        
        firstexp.setBottomBorder()
        first.setBottomBorder()
        second.setBottomBorder()
        third.setBottomBorder()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeaction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeaction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
        
        //firstexp.theme.font = UIFont.systemFont(ofSize: 18)
        firstexp.filterStrings(["Architecture", "Architecture/Architectural Engineering",
                                "Interior Design", "Accounting", "Business Honors Program",
                                "Finance", "International Business", "Management", "Management Information Systems", "Marketing", "Science and Technology Management", "Supply Chain Management", "Advertising",
                                "Communication and Leadership", "Communication Studies", "Corporate Communication", "Human Relations", "Political Communication", "Communication Sciences and Disorders",
                                "Audiology", "Education of the Deaf/Hearing Impaired", "Speech/Language Pathology", "Journalism", "Public Relations", "Radio-Television-Film", "Applied Movement Science", "Health Promotion", "Physical Culture and Sports", "Sport Management", "Aerospace Engineering", "Architectural Engineering", "Biomedical Engineering", "Chemical Engineering", "Civil Engineering", "Computational Engineering", "Electrical and Computer Engineering", "Environmental Engineering", "Geosystems Engineering and Hydrogeology", "Mechanical Engineering", "Petroleum Engineering", "Acting", "Art History", "Arts and Entertainment Technologies", "Dance", "Dance Studies", "Design", "Jazz", "Music", "Music Composition", "Music Performance", "Music Studies", "Choral Music Emphasis", "Instrumental Emphasis", "Studio Art", "Theatre and Dance", "Theatre Studies", "Visual Art Studies", "Environmental Sciences", "Geological Sciences", "Pharmacy", "Nursing", "Chemistry", "Biology", "Computer Science", "Astronomy", "Biochemistry", "Teaching", "BSA", "Human Development", "Families and Society", "Mathematics", "Physics", "Textiles and Apparel", "Consumer Science", "African and African Diaspora Studies", "American Studies", "Anthropology", "Chinese", "Hindi/Urdu", "Japanese", "Korean", "Malayalam", "Sanskrit", "Tamil", "Greek", "Latin", "Classical Studies", "Ancient History", "Classical Archaeology", "Economics", "English", "Ethnic Studies", "Asian American", "Mexican American", "European Studies", "French", "Geography", "German", "Government", "Health and Society", "History", "Human Dimensions of Organizations", "Humanities", "Iberian and Latin American Languages and Cultures", "International Relations and Global Studies", "Islamic Studies", "Italian", "Jewish Studies", "Latin American Studies", "Linguistics", "Middle Eastern Languages and Cultures", "Middle Eastern Studies", "Philosophy", "Psychology", "Religious Studies", "Rhetoric and Writing", "Russian, East European and Eurasian Studies", "Sociology", "Sustainability Studies", "Culinary", "Styling"])
        //firstexp.maxNumberOfResults = 3
        //firstexp.inlineMode = true
        //firstexp.theme = SearchTextFieldTheme.darkTheme()
        //firstexp.startVisible = true
        firstexp.theme.borderColor = UIColor.lightGray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     @IBAction func submit(_ sender: Any) {
     
     if(Lbl1.text == "" || Lbl1.text == "You have to select at least one subject!") {
     Lbl1.text = "You have to select at least one subject!"
     } else {
     
     let id = Auth.auth().currentUser?.uid
     
     // var exp: String = Lbl1.text + "," + Lbl2.text + "," + Lbl3.text + "," + Lbl4.text + "," + Lbl5.text
     
     let question1 = ["Name": name, "Bio": bio, "Expertise1": Lbl1.text, "Expertise2": Lbl2.text, "Expertise3": Lbl3.text, "Expertise4": Lbl4.text, "Expertise5": Lbl5.text]
     
     dbReference = Database.database().reference()
     dbReference?.child("Applied").child(id!).setValue(question1)
     
     performSegue(withIdentifier: "gotofinal", sender: nil)
     
     }
     
     }
     */
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func swipeaction(swipe: UISwipeGestureRecognizer) {
        
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "gotofirston", sender: self)
            break
        case 2:
            sChoice = firstexp.text
            sMotivation = first.text! + second.text! + third.text!
            performSegue(withIdentifier: "gotothird", sender: self)
        default:
            break
            
        }
    }
}
