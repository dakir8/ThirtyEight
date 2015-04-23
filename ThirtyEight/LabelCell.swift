//
//  LabelCellTableViewCell.swift
//  ThirtyEight
//
//  Created by Daniel on 15/4/23.
//  Copyright (c) 2015年 daniel. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
