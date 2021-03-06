//
//  GameScreenClueViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 7.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

//this class is for the clues part of the gamescreen tab view controller
//it is datasource and delegate for the tableview element in the viewController, since the tableview is not a controller, this viewcontroller fills its place

import UIKit

class GameScreenClueViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ViewObserverProtocol {
    var isDisplayingPopup = false
    let gameController = gameControllerSingleton
    var listOfClues: [ClueObject]!
    var tableIndex: Int?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listOfClues = gameController.currentLocation!.clueList
        //set the delegate and datasource of the tableView to be this controller
        registerAsObserver()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: tableview necessary functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfClues.count
    }
    //MARK: populating table view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //check if clue is locked or not
        if (!listOfClues[indexPath.row].lockedStatus){
            print("[GameClueScreen] this cell is not locked")
            let textCellIdentifier = "clueCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! GameScreenCluesTableViewCell
            cell.clueTitle.text = "Clue #\(listOfClues[indexPath.row].clueTier+1)"
            cell.clueSubTitle.text = listOfClues[indexPath.row].clueTitle
            return cell
        }else{
            print("[GameClueScreen] this cell IS locked")
            let textCellIdentifier = "clueCellLocked"
            let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! GameScreenCluesLockedTableViewCell
            cell.clueTitle.text = "Clue #\(listOfClues[indexPath.row].clueTier)"
            return cell
        }
    }
    //MARK: unlock button for a locked cell
    /*@IBAction func unlockClue(sender: UIButton) {
        //get position of the button on the screen
        var buttonPosition = sender.convertPoint(CGPointZero, toView: cluesTableView)
        //get the row the button is on using the coordinate
        var rowOfButton = self.cluesTableView.indexPathForRowAtPoint(buttonPosition)?.row
        listOfClues[rowOfButton!].lockedStatus = false
        print("[GameCluesScreen] ListOfClues: \(listOfClues[rowOfButton!].lockedStatus) GameCTRL: \(gameController.currentLocation!.clueList[rowOfButton!].lockedStatus)")
        cluesTableView.reloadData()
        
    }*/
    
    //MARK: Obeserver functions
    func registerAsObserver() {
        beaconFinderSingleton.registerAsObserver(self)
    }
    
    func receiveNotification() {
        if(!isDisplayingPopup){
            //print("[GameScreen] Jeeben huuben this is popup je je")
            isDisplayingPopup = true
            let popCreator = PopupCreator()
            popCreator.createClueFoundPopup(self)
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "ClueTableContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! CluesTableViewController
            destinationCtrl.parentController = self
        }else if(segue.identifier == "MoveToFullClue"){
            let fullClueViewCtrl = segue.destinationViewController as! FullClueViewController
                let selectedClue = gameController.currentLocation!.clueList[self.tableIndex!]
                fullClueViewCtrl.passedClue = selectedClue
        }
        /*
        if (segue.identifier == "MoveToFullClue"){
            let fullClueViewCtrl = segue.destinationViewController as! FullClueViewController
            if let selectedClueCell = sender as? UITableViewCell {
                let indexPath = cluesTableView.indexPathForCell(selectedClueCell)!
                let selectedClue = gameController.currentLocation!.clueList[indexPath.row]
                fullClueViewCtrl.passedClue = selectedClue
                
            }
        }else if(segue.identifier == "ClueTableContainerSegue"){
            print("container")
        }*/
    }
    
    
}
