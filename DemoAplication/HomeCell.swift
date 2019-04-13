//
//  HomeCell.swift
//  DemoAplication
//
//  Created by Akash Padhiyar on 06/03/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var MyImageView: UIImageView!
    @IBOutlet weak var MyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
