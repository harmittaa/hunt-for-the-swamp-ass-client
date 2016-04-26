//
//  SplashScreenViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 25.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var splashImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "splash_screen")!)
        splashImage.contentMode = UIViewContentMode.ScaleAspectFit
        splashImage.image = UIImage(named: "splash_screen")
        httpRequestControllerSingleton.registerAsSplashScreen(self)
        gameControllerSingleton.allGameModes = []
        httpRequestControllerSingleton.getGameModes()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveToGameScreen(){
        self.performSegueWithIdentifier("StartGameSegue", sender: self)
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
