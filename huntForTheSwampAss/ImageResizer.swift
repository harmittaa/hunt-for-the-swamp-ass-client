//
//  imageResizer.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 25.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit
class ImageResizer{
    init(){
        
    }
    
    func calculateNewDimensionsOfImage(currentImageDimension: CGSize, containerDimension: CGSize) -> CGSize{
        //check image dimensions, which way it will get cropped
        if(currentImageDimension.height >= currentImageDimension.width){
            //check if the image is smaller or bigger than the container, this determines if it will be shrunk or stretched
            let aspectRatio = containerDimension.height / currentImageDimension.height
            return CGSize(width: (currentImageDimension.width * aspectRatio), height: containerDimension.height)
        }
        else{
            let aspectRatio = containerDimension.width / currentImageDimension.width
            return CGSize(width: containerDimension.width, height: (currentImageDimension.height*aspectRatio))
        }
    }
}