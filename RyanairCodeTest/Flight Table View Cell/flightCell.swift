//
//  flightCell.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/5/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import UIKit

class flightCell: UITableViewCell {

    @IBOutlet weak var fareLabel: UILabel!
    @IBOutlet weak var flightNumLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }

    
}
