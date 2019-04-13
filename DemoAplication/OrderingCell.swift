//
//  OrderingCell.swift
//  DemoAplication
//
//  Created by Akash Padhiyar on 09/03/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit
protocol cartDelegate {
    func addClick(at index: IndexPath)
    func removeClick(at index: IndexPath)
}

class OrderingCell: UITableViewCell {
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductQnty: UILabel!
    @IBAction func btnAdd(_ sender: Any) {
        delegate.addClick(at: indexPath)
    }
    
    @IBAction func btnRemove(_ sender: Any) {
        delegate.removeClick(at: indexPath)
    }
    var delegate: cartDelegate!
    var indexPath: IndexPath!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
