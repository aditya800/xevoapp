//
//  thirdcustomcell.swift
//  Xevo
//
//  Created by Aditya Saxena on 25/05/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class thirdcustomcell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var labelMain: UIButton!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
