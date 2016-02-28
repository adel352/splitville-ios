//
//  BillItemCell.swift
//  SplitVille
//
//  Created by Nabil Maadarani on 2016-02-28.
//  Copyright © 2016 Nabil. All rights reserved.
//

import UIKit

class BillItemCell: UITableViewCell {

    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
