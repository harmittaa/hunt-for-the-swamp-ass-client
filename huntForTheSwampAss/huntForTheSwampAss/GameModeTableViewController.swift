//
//  GameModeTableViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 6.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class GameModeTableViewController: UITableViewController {
    let gameController = gameControllerSingleton
    var gameModes: [GameModeObject]!
    var passedIndex: Int?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.gameModes = gameController.allGameModes!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let coreDataManager:DataController = DataController.dataManagerSingleton
         print("count of objects blim blom: \(coreDataManager.fetchObject("Hunt").count)")
         */
        //MARK: sample data is loaded
        /*let a = coreDataManager.fetchObject("GameMode")
         gameModes = a
         print("this is from the other controller: Size : \(a.count)  \(a)")
         */
        //gameModes.append(GameMode(name:"Bar Crawl"))
        //gameModes.append(GameMode(name:"jeeben"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return gameModes.count
    }
    
    //MARK: configuring cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GameModeTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GameModeTableViewCell
        let gameMode = gameModes[indexPath.row]
        let listOfHunts = gameMode.huntList
        // set data for the hunt cells
        cell.gaemModeTitle.text = gameMode.gameModeTitle
        cell.gameModeDesc.text = gameMode.gameModeDescription
        //create the background images for the cell using the list of hunts that the gameMode has
        var xCoord:CGFloat = 0
        for i in listOfHunts{
            print("[cell] making a BG")
            let image = i.huntImage
            let imageView = UIImageView(image: image!)
            let newSize = calculateNewDimensionsOfImage(image!.size)
            imageView.frame = CGRect(x: xCoord, y: 0, width: newSize.width, height: newSize.height)
            //to get to the view of the cell, use self.contentView
            cell.contentView.addSubview(imageView)
            cell.contentView.sendSubviewToBack(imageView)
            //self.contentView.bringSubviewToFront(gameModeDesc)
            //self.contentView.bringSubviewToFront(gameModeImage)
            cell.listOfBackgroundImages.append(imageView)
            xCoord += newSize.width
        }
        return cell
    }
    
    //MARK: when a cell is selected
    //get the cell index and pass it into the segue for the new viewcontroller
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        passedIndex = indexPath.row
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
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //if (segue.identifier == "MoveToHuntsScreen"){
            //let huntsViewController = segue.destinationViewController as! HuntTableViewController
            //cast the sender as a GamModeTableViewCell to access the index path
            if let selectedGameModeCell = sender as? GameModeTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedGameModeCell)!
                /*let selectedGameModesHunts = gameController.allGameModes![indexPath.row].huntList
                huntsViewController.listOfHunts = selectedGameModesHunts*/
                print("[index] \(indexPath.row)")
                print(gameControllerSingleton.allGameModes![indexPath.row].huntList)
                gameControllerSingleton.selectedGameMode = gameControllerSingleton.allGameModes![indexPath.row]
            }
        //}
    }
    
    
}
