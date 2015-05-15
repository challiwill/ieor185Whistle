//
//  usersVC.swift
//  ChatApp
//
//  Created by Black_Shark on 4/8/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

// TODO somehow get rid of bottom bar that is showing up on this view

import UIKit

var userName = ""
var myTrip:PFObject = PFObject(className: "dummy")

class usersVC: UIViewController, UITableViewDataSource {

    @IBOutlet var uiView: UIView!
    @IBOutlet weak var resultsTable: UITableView!
    var resultsUsernameArray = [String]()
    var resultsProfileNameArray = [String]()
    var resultsImageFiles = [PFFile]()
    var resultsCompanyNameArray = [String]()
    var resultsLeavingInArray = [Int]()
    var resultsFeedbackArray = [Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        resultsTable.frame = CGRectMake(0, 0, theWidth, theHeight-64)
        
        userName = PFUser.currentUser()!.username!
        var refreshTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "refreshUsers", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.resultsUsernameArray.removeAll(keepCapacity: false)
        self.resultsProfileNameArray.removeAll(keepCapacity: false)
        self.resultsImageFiles.removeAll(keepCapacity: false)
        self.resultsCompanyNameArray.removeAll(keepCapacity: false)
        self.resultsLeavingInArray.removeAll(keepCapacity: false)
        self.resultsFeedbackArray.removeAll(keepCapacity: false)
        
       refreshUsers()
    }
    
    func refreshUsers() {
        resultsUsernameArray.removeAll(keepCapacity: false)
        resultsProfileNameArray.removeAll(keepCapacity: false)
        resultsImageFiles.removeAll(keepCapacity: false)
        resultsCompanyNameArray.removeAll(keepCapacity: false)
        resultsLeavingInArray.removeAll(keepCapacity: false)
        resultsFeedbackArray.removeAll(keepCapacity: false)
        
        var tripsQuery = PFQuery(className: "Trip")
        tripsQuery.whereKey("to", equalTo: myTrip["to"] as! String)
        tripsQuery.whereKey("domain", equalTo: myTrip["domain"] as! String)
        tripsQuery.whereKey("userEmail", notEqualTo: userName)
        tripsQuery.whereKey("leavingEnd", greaterThan: NSDate())
        tripsQuery.whereKey("from", nearGeoPoint: myTrip["from"] as! PFGeoPoint, withinMiles: 0.25)
        
        var trips = tripsQuery.findObjects()
        // TODO make it not add the same person multiple times even if they have multiple trips. just use most recent trip
        for trip in trips! {
            var userQuery = PFQuery(className: "_User")
            userQuery.whereKey("username", equalTo: trip["userEmail"] as! String)
            
            var users = userQuery.findObjects()
            for user in users! {
                if (!contains(resultsUsernameArray, user.username!!)) {
                    self.resultsUsernameArray.append(user.username!!)
                    self.resultsProfileNameArray.append(user["profileName"] as! String)
                    self.resultsImageFiles.append(user["photo"] as! PFFile)
                    self.resultsCompanyNameArray.append(user["company"] as! String)
                    var ratingQuery = PFQuery(className: "Rating")
                    ratingQuery.whereKey("username", equalTo: user.username!!)
                    var ratings = ratingQuery.findObjects()
                    for rating in ratings! {
                        var avg = 5*((rating["score"] as! Float)/(rating["raters"] as! Float))
                        self.resultsFeedbackArray.append(floor(avg))
                    }
                    
                    self.resultsTable.reloadData()
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! resultsCell
        otherName = cell.usernameLbl.text!
        otherProfileName = cell.profileNameLbl.text!
        otherImg = cell.profileImg.image
        
        self.performSegueWithIdentifier("goToConversationVC", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor  = UIColor(red: 0.141, green: 0.486, blue: 0.671, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.808, green: 0.824, blue: 0.831, alpha: 1.0)
        let logo = UIImage(named: "logo_small_light.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsUsernameArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:resultsCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! resultsCell
        
        cell.usernameLbl.text = self.resultsUsernameArray[indexPath.row]
        cell.profileNameLbl.text = self.resultsProfileNameArray[indexPath.row]
        cell.companyLbl.text = self.resultsCompanyNameArray[indexPath.row]
        // TODO updated leaving in time
        switch resultsFeedbackArray[indexPath.row] {
        case 1:
            cell.ratingImg.image = UIImage(named: "star1.png")
        case 2:
            cell.ratingImg.image = UIImage(named: "star2.png")
        case 3:
            cell.ratingImg.image = UIImage(named: "star3.png")
        case 4:
            cell.ratingImg.image = UIImage(named: "star4.png")
        case 5:
            cell.ratingImg.image = UIImage(named: "star5.png")
        default:
            // TODO this should not be the default
            cell.ratingImg.image = UIImage(named: "star5.png")
        }
        
        resultsImageFiles[indexPath.row].getDataInBackgroundWithBlock {
            (imageData:NSData?, error:NSError?) -> Void in
            
            if error == nil {
                let image = UIImage(data: imageData!)
                cell.profileImg.image = image
            }
        }
        return cell
    }
    
    @IBAction func logoutBtn_click(sender: AnyObject) {
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
