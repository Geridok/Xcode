//
//  SettingTableViewCell.swift
//  Tables&Collections
//
//  Created by Vladimir Mustafin on 12.10.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
