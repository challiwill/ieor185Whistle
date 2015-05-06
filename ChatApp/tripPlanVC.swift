//
//  tripPlanVC.swift
//  ChatApp
//
//  Created by Black_Shark on 4/13/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit
import Foundation

class tripPlanVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var goingToTxt: UITextField!
    @IBOutlet weak var timeOneBtn: UIButton!
    @IBOutlet weak var timeTwoBtn: UIButton!
    @IBOutlet weak var timeThreeBtn: UIButton!
    @IBOutlet var frameView: UIView!
    var scrollViewOriginalY:CGFloat = 0.0
    var leavingIn:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO relative placement of objects
        let theWidth = view.frame.size.width
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor  = UIColor(red: 0.141, green: 0.486, blue: 0.671, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.808, green: 0.824, blue: 0.831, alpha: 1.0)
        let logo = UIImage(named: "logo_small_light.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
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
        let begin = NSDate()
        let end = NSDate(timeIntervalSinceNow: leavingIn*60)
        trip["userEmail"] = user!.email
        trip["leavingBegin"] = begin
        // TODO set ["from"] field to geolocation
        trip["leavingEnd"] = end
        trip["to"] = goingToTxt.text
        trip.saveInBackgroundWithBlock {
            (success: Bool, error:NSError?) -> Void in
            
            if success == true {
                println("trip saved")
                myTrip = trip
                self.performSegueWithIdentifier("goToUsersVC", sender: self)
            } else {
                // TODO make error message that user sees
                println("can't save trip")
            }
        }

    }

    @IBAction func timeOneBtn_click(sender: UIButton) {
        self.view.endEditing(true)
        timeTwoBtn.selected = false
        timeThreeBtn.selected = false
        sender.selected = true
        leavingIn = 5
    }
    
    @IBAction func timeTwoBtn_click(sender: UIButton) {
        self.view.endEditing(true)
        timeOneBtn.selected = false
        timeThreeBtn.selected = false
        sender.selected = true
        leavingIn = 10
    }
    
    @IBAction func timeThreeBtn_click(sender: UIButton) {
        self.view.endEditing(true)
        timeOneBtn.selected = false
        timeTwoBtn.selected = false
        sender.selected = true
        leavingIn = 15
    }

    @IBAction func logoutBtn_click(sender: AnyObject) {
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
   
}
