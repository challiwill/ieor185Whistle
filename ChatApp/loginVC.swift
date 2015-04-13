//
//  loginVC.swift
//  ChatApp
//
//  Created by Black_Shark on 3/30/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit

class loginVC: UIViewController {

    
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        welcomeLbl.center = CGPointMake(theWidth/2, 130)
        usernameTxt.frame = CGRectMake(16, 200, theWidth-32, 30)
        passwordTxt.frame = CGRectMake(16, 240, theWidth-32, 30)
        loginBtn.center = CGPointMake(theWidth/2, 330)
        signupBtn.center = CGPointMake(theWidth/2, theHeight-30)
        
        //TODO add check to see if already logged in
        var fbLogin:FBSDKLoginButton = FBSDKLoginButton()
        fbLogin.center = CGPointMake(theWidth/2, theHeight-100)
        self.view.addSubview(fbLogin)
        // TODO add delegate methods
        // http://www.brianjcoleman.com/tutorial-how-to-use-login-in-facebook-sdk-4-0-for-swift/
        // fbLogin.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func loginBtn_click(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTxt.text, password: passwordTxt.text) {
            (user:PFUser!, logInError:NSError!) -> Void in
            
            if logInError == nil {
                println("log in")
                self.performSegueWithIdentifier("goToTripPlanVC", sender: self)
            } else {
                println("error log in")
            }
        }
    }

}

