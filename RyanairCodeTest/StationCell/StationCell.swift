//
//  StationCell.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/4/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import UIKit

class StationCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var Scode: UILabel!
    @IBOutlet weak var Sname: UILabel!
    @IBOutlet weak var Simage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
