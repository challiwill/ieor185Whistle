//
//  usersVC.swift
//  ChatApp
//
//  Created by Black_Shark on 4/8/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit

var userName = ""

class usersVC: UIViewController, UITableViewDataSource {

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
        
        let predicate = NSPredicate(format: "username != '"+userName+"'")
        var query = PFQuery(className: "_User", predicate: predicate)
        var objects = query.findObjects()
        
        for object in objects! {
            self.resultsUsernameArray.append(object.username!!)
            self.resultsProfileNameArray.append(object["profileName"] as! String)
            self.resultsImageFiles.append(object["photo"] as! PFFile)
            self.resultsCompanyNameArray.append(object["company"] as! String)
            // TODO need to deal with leavingBegina and leavingEnd
            self.resultsFeedbackArray.append(object["rating"] as! Float)
            
            self.resultsTable.reloadData()
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
            cell.ratingImg.image = UIImage(named: "1star.gif")
        case 2:
            cell.ratingImg.image = UIImage(named: "2star.gif")
        case 3:
            cell.ratingImg.image = UIImage(named: "3star.gif")
        case 4:
            cell.ratingImg.image = UIImage(named: "4star.gif")
        case 5:
            cell.ratingImg.image = UIImage(named: "5star.gif")
        default:
            // TODO this should not be the default
            cell.ratingImg.image = UIImage(named: "5star.gif")
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
