//
//  tripPlanVC.swift
//  ChatApp
//
//  Created by Black_Shark on 4/13/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit
import Foundation

var tripPlanSource:Int = 0

class tripPlanVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var leavingEndTxt: UITextField!
    @IBOutlet var frameView: UIView!
    var scrollViewOriginalY:CGFloat = 0.0
    
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    func keyboardWasShown(notification:NSNotification) {
        if (UIScreen.mainScreen().bounds.height == 568) {
            let dict:NSDictionary = notification.userInfo!
            let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
            let rect:CGRect = s.CGRectValue()
            
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
                self.frameView.frame.origin.y = self.scrollViewOriginalY - rect.height/3
                }, completion: {
                    (finished:Bool) in
            })
        }
    }

    func keyboardWillHide(notification:NSNotification) {
        let dict:NSDictionary = notification.userInfo!
        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect:CGRect = s.CGRectValue()
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
            self.frameView.frame.origin.y = self.scrollViewOriginalY
            }, completion: {
                (finished:Bool) in
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.barTintColor  = UIColor(red: 0.337, green: 0.471, blue: 0.518, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.988, green: 0.808, blue: 0.502, alpha: 1.0)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    @IBAction func goBtn_click(sender: AnyObject) {
        //        TODO Do some sort of validity check
        //        TODO make sure to sort users
        // TODO do validity test on numbers/dates and accept multiple input styles
        let trip = PFObject(className: "Trip")
        let user = PFUser.currentUser()
        let begin = NSDate(timeIntervalSinceNow: 0)
        // TODO make buttons choose time (15,20,30 min)
        let end = NSDate(timeIntervalSinceNow: 15)
        trip["userEmail"] = user!.email
        trip["leavingBegin"] = begin
        trip["leavingEnd"] = end
        trip.saveInBackgroundWithBlock {
            (success: Bool, error:NSError?) -> Void in
            
            if success == true {
                println("trip saved")
                myTrip = trip
                self.performSegueWithIdentifier("goToUsersVC", sender: self)
            } else {
                // TODO make error message that user sees
            }
        }

    }
    
    @IBAction func logoutBtn_click(sender: AnyObject) {
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
   
}
