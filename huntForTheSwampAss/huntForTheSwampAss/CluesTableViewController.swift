//
//  CluesTableViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 20.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class CluesTableViewController: UITableViewController {
    var parentController: GameScreenClueViewController?
    var listOfClues: [ClueObject]?
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfClues = gameControllerSingleton.currentLocation!.clueList
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "gamemode_bg"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfClues!.count
    }
    
    func unlockClue(row: Int) {
        listOfClues![row].lockedStatus = false
        print("[GameCluesScreen] ListOfClues: \(listOfClues![row].lockedStatus) GameCTRL: \(gameController.currentLocation!.clueList[row].lockedStatus)")
        self.tableView.reloadData()
        
    }
    //MARK: select a cell
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //get cell that was clicked by using the cellforrow method
        let celleroni = self.tableView(self.tableView, cellForRowAtIndexPath: indexPath)
        print(celleroni.reuseIdentifier!)
        
        //if else depending on what kind of cell was clicked, checked by using the identifier
        if(celleroni.reuseIdentifier == "clueCell"){
            self.parentController!.tableIndex = indexPath.row
            self.parentController?.performSegueWithIdentifier("MoveToFullClue", sender: self.parentController)
        }else if(celleroni.reuseIdentifier == "clueCellLocked"){
            unlockClue(indexPath.row)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //check if clue is locked or not, configure accordingly
        if (!listOfClues![indexPath.row].lockedStatus){
            let textCellIdentifier = "clueCell"
            let cell = self.tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! GameScreenCluesTableViewCell
            cell.clueTitle.text = "Clue #\(listOfClues![indexPath.row].clueTier+1)"
            cell.clueSubTitle.text = listOfClues![indexPath.row].clueTitle
            cell.backgroundColor = UIColor.clearColor()
            cell.clueCellImage.image = UIImage(named: "clue_full")
            cell.clueCellImage.contentMode = UIViewContentMode.ScaleAspectFit
            return cell
        }else{
            print("[GameClueScreen] this cell IS locked")
            let textCellIdentifier = "clueCellLocked"
            let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! GameScreenCluesLockedTableViewCell
            cell.clueTitle.text = "Clue #\(listOfClues![indexPath.row].clueTier+1)"
            cell.backgroundColor = UIColor.clearColor()
            cell.clueCellImage.image = UIImage(named: "clue_locked")
            cell.clueCellImage.contentMode = UIViewContentMode.ScaleAspectFit
            return cell
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
