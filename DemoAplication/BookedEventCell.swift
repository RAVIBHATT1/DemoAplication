//
//  BookedEventCell.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/22/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class BookedEventCell: UITableViewCell {

    
    @IBOutlet var lblEventName: UILabel!
    
    @IBOutlet var lblEventCname: UILabel!
    
    @IBOutlet var lblEventEname: UILabel!
    
    @IBOutlet var lblEventDate: UILabel!
    
    @IBOutlet var lblEventTIme: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
