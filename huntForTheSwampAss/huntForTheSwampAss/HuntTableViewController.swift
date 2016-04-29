//
//  HuntTableViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 6.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//
// used for populating the Hunt table view as well as getting images for clues for the selected hunt

import UIKit

class HuntTableViewController: UITableViewController{
    
    let gameController = gameControllerSingleton
    var listOfHunts: [HuntObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "hunts_bg"))
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
        return gameControllerSingleton.selectedGameMode!.huntList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "HuntTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HuntTableViewCell
        print("[HuntTableViewCtrl]cell : \(cell)")
        // set data for the hunt cells
        cell.huntTitle.text = gameControllerSingleton.selectedGameMode!.huntList[indexPath.row].huntTitle
        
        cell.huntDesc.text = gameControllerSingleton.selectedGameMode!.huntList[indexPath.row].huntDescription
        
        cell.huntImage.image = gameControllerSingleton.selectedGameMode!.huntList[indexPath.row].huntImage
        
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("[HuntTableView] exiting hunt table view")
        gameController.currentHunt = gameController.selectedGameMode?.huntList[indexPath.row]
        print("[HuntTableView]the following hunt is chosen \(gameController.currentHunt?.huntTitle)")
        print("[HuntTableView]the row of the hunt is \(indexPath.row)")
        // get images for all of the clues in this hunt
        httpRequestControllerSingleton.getImages((gameControllerSingleton.currentHunt?.locationList)!)
        httpRequestControllerSingleton.getImagesForLocations((gameControllerSingleton.currentHunt?.locationList)!)
        // sets the image data as fetched so it won't be fetched again
        gameControllerSingleton.currentHunt?.setDataFetched(true)
        gameController.currentLocation = gameController.currentHunt!.locationList![0]
        // creates a new object into the core data
        gameController.updateSavedHunt()
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
    /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     //let gameScreenController = segue.destinationViewController as! GameScreenTabBarController
     if let selectedHuntCell = sender as? HuntTableViewCell {
     //let indexPath = tableView.indexPathForCell(selectedHuntCell)!
     let newCurrentHunt = gameController.currentHunt//gameController.allHunts![indexPath.row]
     //gameController.setCurrentHunt(newCurrentHunt)
     print("[HuntTableViewController] current hunt set as: \(newCurrentHunt)")
     //gameController.currentLocation = gameController.currentHunt?.locationList[0]
     }
     
     }*/
    
    
}
