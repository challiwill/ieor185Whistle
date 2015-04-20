//
//  tripPlanVC.swift
//  ChatApp
//
//  Created by Black_Shark on 4/13/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit

var tripPlanSource:Int = 0

class tripPlanVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Plan Trip"
        // TODO relative placement of objects
        let theWidth = view.frame.size.width
        if (tripPlanSource == 2) {
            let endLbl = UILabel(frame: CGRectMake(5, 70, theWidth-10, 100))
            endLbl.text = "Thank you for using WalkMe and for giving peer feedback. We depend on this feedback to make the experience as safe as possible."
            endLbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
            endLbl.backgroundColor = UIColor.greenColor()
            endLbl.textColor = UIColor.darkGrayColor()
            endLbl.numberOfLines = 0
            endLbl.textAlignment = NSTextAlignment.Center
            endLbl.layer.masksToBounds = true
            endLbl.layer.cornerRadius = 10
            endLbl.sizeToFit()
            endLbl.frame.size.width = theWidth-10
            view.addSubview(endLbl)
        }
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
