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
    
    @IBOutlet weak var cluesTableView:UITableView!
    var isDisplayingPopup = false
    let gameController = gameControllerSingleton
    var listOfClues: [ClueObject]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listOfClues = gameController.currentLocation!.clueList
        //set the delegate and datasource of the tableView to be this controller
        cluesTableView.delegate = self
        cluesTableView.dataSource = self
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
            cell.clueTitle.text = "Clue #\(listOfClues[indexPath.row].clueTier)"
            cell.clueSubTitle.text = listOfClues[indexPath.row].clueText
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
    @IBAction func unlockClue(sender: UIButton) {
        //get position of the button on the screen
        var buttonPosition = sender.convertPoint(CGPointZero, toView: cluesTableView)
        //get the row the button is on using the coordinate
        var rowOfButton = self.cluesTableView.indexPathForRowAtPoint(buttonPosition)?.row
        listOfClues[rowOfButton!].lockedStatus = false
        print("[GameCluesScreen] ListOfClues: \(listOfClues[rowOfButton!].lockedStatus) GameCTRL: \(gameController.currentLocation!.clueList[rowOfButton!].lockedStatus)")
        cluesTableView.reloadData()
        
    }
    
    //MARK: Obeserver functions
    func registerAsObserver() {
        beaconFinderSingleton.registerAsObserver(self)
    }
    
    func receiveNotification() {
        if(!isDisplayingPopup){
            isDisplayingPopup = true
            let noAuthAlert = UIAlertController.init(title: gameController.currentLocation!.locationTitle, message: "Found a thing", preferredStyle: .Alert)
            print("[ViewController] received notification as observer")
            //custom action with a segue
            
            let settingsAction = UIAlertAction(title: "Continue", style: .Default, handler: { (testAction) -> Void in
                self.performSegueWithIdentifier("LocationDiscoveredSegue", sender: self)
                self.gameController.currentLocation!.isFound = true
            })
            // add actions to the alert
            noAuthAlert.addAction(settingsAction)
            //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.presentViewController(noAuthAlert, animated: true, completion: nil)
            //})
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let fullClueViewCtrl = segue.destinationViewController as! FullClueViewController
        
        if (segue.identifier == "MoveToFullClue"){
            if let selectedClueCell = sender as? UITableViewCell {
                let indexPath = cluesTableView.indexPathForCell(selectedClueCell)!
                let selectedClue = listOfClues[indexPath.row]
                fullClueViewCtrl.passedClue = selectedClue
                
            }
            
        }
    }
    
    
}
