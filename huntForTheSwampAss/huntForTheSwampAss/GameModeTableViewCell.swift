//
//  GameModeTableViewCell.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 6.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class GameModeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameModeImage: UIImageView!
    @IBOutlet weak var gaemModeTitle: UILabel!
    @IBOutlet weak var gameModeDesc: UILabel!
    var listOfBackgroundImages = [UIImageView]()
    var listOfHunts = [HuntObject]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
