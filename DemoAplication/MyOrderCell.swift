//
//  MyOrderCell.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/16/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class MyOrderCell: UITableViewCell {

    @IBOutlet var orderId: UILabel!
    @IBOutlet var orderDate: UILabel!
    @IBOutlet var orderTime: UILabel!
    @IBOutlet var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
