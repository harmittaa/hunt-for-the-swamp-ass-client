//
//  UserProfileViewController.swift
//  huntForTheSwampAss
//
//  Created by iosdev on 29.4.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var signUpPassword: UITextField!
    @IBOutlet weak var signUpUsername: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginFunction(sender: UIButton) {
        print("[UserProfileVC] login called")
        handleLogin()
    }

    @IBAction func signUpFunction(sender: UIButton) {
        print("[UserProfileVC] signup called")
        handleRegistration()
    }
    
    func handleLogin() {
        if loginUsername.text != nil && loginPassword.text != nil {
            print("[UserProfileVC] Logging in will happen")
            httpRequestControllerSingleton.login(loginUsername.text!, password: loginPassword.text!)
        } else {
            print("[UserProfileVC] user didn't fill all login fields")
        }
    }
    
    func handleRegistration() {
        if signUpUsername.text != nil && signUpPassword.text != nil {
            print("[UserProfileVC] pass & username found, registering...")
            httpRequestControllerSingleton.registerUser(signUpUsername.text!, password: signUpPassword.text!, media: "media_here", description: "desc_here")
        } else {
            print("[UserProfileVC] user didn't fill all registration fields")
        }
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
