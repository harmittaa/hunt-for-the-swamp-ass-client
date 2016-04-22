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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        var xCoord:CGFloat = 0
        for i in 1...5{
            print("[cell] making a BG")
            let imageName = "test.jpg"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            let newSize = calculateNewDimensionsOfImage(image!.size)
            //if self.listOfBackgroundImages.count == 0{
            imageView.frame = CGRect(x: xCoord, y: 0, width: newSize.width, height: newSize.height)
            /*}
            else{
                let previousView = listOfBackgroundImages[listOfBackgroundImages.count-1]
                imageView.frame = CGRect(x: previousView.frame.width, y: 0, width: newSize.width, height: newSize.height)
            }*/
            //to get to the view of the cell, use self.contentView
            self.contentView.addSubview(imageView)
            self.contentView.sendSubviewToBack(imageView)
            //self.contentView.bringSubviewToFront(gameModeDesc)
            //self.contentView.bringSubviewToFront(gameModeImage)
            self.listOfBackgroundImages.append(imageView)
            xCoord += newSize.width
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func calculateNewDimensionsOfImage(imageDimension: CGSize) -> CGSize{
        let currentSize = CGSize(width: 90, height: 90)
        print("[sizecalc] received size: \(imageDimension.height)   \(imageDimension.width)")
        print("[sizecalc] container size: \(currentSize.height)   \(currentSize.width)")
        //check image dimensions, which way it will get cropped
        if(imageDimension.height >= imageDimension.width){
            //check if the image is smaller or bigger than the container, this determines if it will be shrunk or stretched
            let aspectRatio = currentSize.height / imageDimension.height
            return CGSize(width: (imageDimension.width * aspectRatio), height: currentSize.height)
        }
        else{
            let aspectRatio = currentSize.width / imageDimension.width
            return CGSize(width: currentSize.width, height: (imageDimension.height*aspectRatio))
        }
    }
}
