//
//  ParticipantCell.swift
//  SplitVille
//
//  Created by Zoumite Franck Armel Mamboue on 2016-02-28.
//  Copyright © 2016 Nabil. All rights reserved.
//

import UIKit

class ParticipantCell: UITableViewCell {

    @IBOutlet weak var participantImageView: UIImageView!
    
    @IBOutlet weak var participantName: UILabel!
    
    @IBOutlet weak var participantDistance: UILabel!
    
    @IBOutlet weak var checkbox: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
