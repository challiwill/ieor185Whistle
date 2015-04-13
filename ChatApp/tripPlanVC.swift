//
//  tripPlanVC.swift
//  ChatApp
//
//  Created by Black_Shark on 4/13/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit

class tripPlanVC: UIViewController {
//TODO give popup if coming from 'tripCompleted' to thank for feedback
// and say we hope your experience with the app was positive
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Plan Trip"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func goBtn_click(sender: AnyObject) {
        //        TODO Do some sort of validity check
        //        TODO make sure to sort users
        self.performSegueWithIdentifier("goToUsersVC", sender: self)
    }
    @IBAction func logoutBtn_click(sender: AnyObject) {
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
   
}
