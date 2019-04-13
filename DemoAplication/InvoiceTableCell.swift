//
//  InvoiceTableCell.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/19/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class InvoiceTableCell: UITableViewCell {
    @IBOutlet var lblOrdTitle: UILabel!
    @IBOutlet var lblOrdPrice: UILabel!
    @IBOutlet var lblOrdQnty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
