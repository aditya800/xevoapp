//
//  customCell.swift
//  Xevo
//
//  Created by Aditya Saxena on 18/05/18.
//  Copyright © 2018 aditya saxena. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var mainBtn: UIButton!
    @IBOutlet weak var detailLbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
