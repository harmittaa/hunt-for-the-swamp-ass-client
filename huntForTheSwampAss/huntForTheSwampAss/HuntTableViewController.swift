//
//  HuntTableViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 6.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class HuntTableViewController: UITableViewController, ViewObserverProtocol {

    let gameController = gameControllerSingleton
    var listOfHunts: [HuntObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("[HuntsTableViewController] \(listOfHunts)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //MARK: sample data is loaded
        
        registerAsObserver()
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
        return listOfHunts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "HuntTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HuntTableViewCell
        print("[HuntTableViewCtrl]cell : \(cell)")
        cell.huntTitle.text = listOfHunts[indexPath.row].huntTitle
        cell.huntDesc.text = listOfHunts[indexPath.row].huntDescription
        cell.huntStartDate.text = String(listOfHunts[indexPath.row].huntStartDate)

        return cell
    }
    
    /*override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("delegate \(tableView.delegate)")
        print("[HuntTableView] help pls \(indexPath.row)")
        let cell = tableView.dequeueReusableCellWithIdentifier("HuntTableViewCell", forIndexPath: indexPath) as? HuntTableViewCell
        //print(cell)
        return indexPath
    }*/
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("[HuntTableView] exiting hunt table view")
        gameController.currentHunt = gameController.allHunts![indexPath.row]
        gameController.currentLocation = gameController.currentHunt!.locationList[0]
    }
    
    //MARK: Obeserver functions
    func registerAsObserver() {
        beaconFinderSingleton.registerAsObserver(self)
    }
    
    func receiveNotification() {
        let noAuthAlert = UIAlertController.init(title: "gameController.currentLocation!.locationTitle", message: "Found a thing", preferredStyle: .Alert)
        print("[ViewController] received notification as observer")
        //custom action with a segue
        let settingsAction = UIAlertAction(title: "Continue", style: .Default, handler: { (testAction) -> Void in
            self.performSegueWithIdentifier("LocationDiscoveredSegue", sender: self)
            self.gameController.currentLocation!.isFound = true
        })
        // add actions to the alert
        noAuthAlert.addAction(settingsAction)
        presentViewController(noAuthAlert, animated: true, completion: nil)
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
