//
//  GameScreenCluesLockedTableViewCell.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 13.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class GameScreenCluesLockedTableViewCell: UITableViewCell {
    @IBOutlet weak var clueTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func unlockButtonAction(sender: UIButton) {
        print("[LockedClueCell] unlocking clue")
    }

}
