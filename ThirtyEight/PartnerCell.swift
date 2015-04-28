//
//  PartnerTableCellTableViewCell.swift
//  ThirtyEight
//
//  Created by 邱建平 on 15/4/18.
//  Copyright (c) 2015年 daniel. All rights reserved.
//

import UIKit

class PartnerCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
