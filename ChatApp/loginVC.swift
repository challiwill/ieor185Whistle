//
//  loginVC.swift
//  ChatApp
//
//  Created by Black_Shark on 3/30/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit

class loginVC: UIViewController {

    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet var loginVC: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        logoImg.center = CGPointMake(theWidth/2, 114)
        tagLbl.center = CGPointMake(theWidth/2, 208)
        usernameTxt.frame = CGRectMake(40, 257, theWidth-80, 30)
        passwordTxt.frame = CGRectMake(40, 289, theWidth-80, 30)
        loginBtn.frame = CGRectMake(40, 339, theWidth/2-40, 45)
        signupBtn.frame = CGRectMake(theWidth/2, 339, theWidth/2-40, 45)
        
        //TODO add check to see if already logged in
        //        var fbLogin:FBSDKLoginButton = FBSDKLoginButton()
        //        fbLogin.center = CGPointMake(theWidth/2, theHeight-100)
        //        self.view.addSubview(fbLogin)
        // TODO add delegate methods
        // http://www.brianjcoleman.com/tutorial-how-to-use-login-in-facebook-sdk-4-0-for-swift/
        // fbLogin.delegate = self
        
        let tapScrollViewGesture = UITapGestureRecognizer(target: self, action: "didTapScrollView")
        tapScrollViewGesture.numberOfTapsRequired = 1
        loginVC.addGestureRecognizer(tapScrollViewGesture)
    }

    func didTapScrollView() {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
//        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func loginBtn_click(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTxt.text!, password: passwordTxt.text!) {
            (user:PFUser?, logInError:NSError?) -> Void in
            
            if (user != nil && logInError == nil) {
                println("log in")
                self.performSegueWithIdentifier("goToTripPlanVC", sender: self)
            } else {
                println("error log in")
            }
        }
    }

}

