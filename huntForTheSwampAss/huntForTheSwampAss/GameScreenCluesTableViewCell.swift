//
//  GameScreenCellTableViewCell.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 7.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

//this class is a template cell for the clues screen of the game screen

import UIKit

class GameScreenCluesTableViewCell: UITableViewCell {
    //MARK: ui elements
    @IBOutlet weak var clueTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
