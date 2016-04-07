//
//  GameScreenClueViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 7.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class GameScreenClueViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cluesTableView:UITableView!
    
    var listOfClues = ["jeeben","huuben","zeeben","gaben"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cluesTableView.delegate = self
        cluesTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfClues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let textCellIdentifier = "clueCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! GameScreenCluesTableViewCell
        
        cell.clueTitle.text = listOfClues[indexPath.row]
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
