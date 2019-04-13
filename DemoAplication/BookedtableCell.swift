//
//  BookedtableCell.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/22/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class BookedtableCell: UITableViewCell {

    @IBOutlet var lblTblName: UILabel!
    
    @IBOutlet var lblTblCustName: UILabel!
    
    @IBOutlet var lblNoOfPerson: UILabel!
    
    @IBOutlet var lblTblDesc: UILabel!
    
    @IBOutlet var lblTblDate: UILabel!
    
    @IBOutlet var lblTblTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
