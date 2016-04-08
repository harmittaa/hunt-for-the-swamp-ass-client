//
//  ViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 5.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var teamButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        /*let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Hunt")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            var queryResult = results as! [NSManagedObject]
            print("got a result \(queryResult)")
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }*/
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

