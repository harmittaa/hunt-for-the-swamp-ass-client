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
        print("[imageResizer] received SizeOf Image: \(currentImageDimension)")
        print("[imageResizer] received SizeOf container: \(containerDimension)")
        if(currentImageDimension.height >= currentImageDimension.width){
            //check if the image is smaller or bigger than the container, this determines if it will be shrunk or stretched
            let aspectRatio = containerDimension.height / currentImageDimension.height
            print("[imageResizer] finalSize: \(CGSize(width: (currentImageDimension.width * aspectRatio), height: containerDimension.height))")
            return CGSize(width: (currentImageDimension.width * aspectRatio), height: containerDimension.height)
        }
        else{
            let aspectRatio = containerDimension.width / currentImageDimension.width
            print("[imageResizer] finalSize: \(CGSize(width: (currentImageDimension.width * aspectRatio), height: containerDimension.height))")
            return CGSize(width: containerDimension.width, height: (currentImageDimension.height*aspectRatio))
        }
    }
}