//
//  HuntTableViewCell.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 6.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class HuntTableViewCell: UITableViewCell {
    @IBOutlet weak var huntImage: UIImageView!
    @IBOutlet weak var huntTitle: UILabel!
    @IBOutlet weak var huntDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
