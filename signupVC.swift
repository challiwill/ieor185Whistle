//
//  signupVC.swift
//  ChatApp
//
//  Created by Black_Shark on 3/30/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit

class signupVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var addImgBtn: UIButton!
    @IBOutlet weak var underlineLbl: UILabel!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var profileNameTxt: UITextField!
    @IBOutlet weak var companyNameTxt: UITextField!
    @IBOutlet weak var signupBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        profileImg.center = CGPointMake(theWidth/2, 140)
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        profileImg.clipsToBounds = true
        
        addImgBtn.center = CGPointMake(theWidth/2, self.profileImg.frame.maxY+20)
        underlineLbl.center = CGPointMake(theWidth/2, self.addImgBtn.frame.maxY-5)
        usernameTxt.frame = CGRectMake(16, 240, theWidth-32, 30)
        passwordTxt.frame = CGRectMake(16, 273, theWidth-32, 30)
        profileNameTxt.frame = CGRectMake(16, 306, theWidth-32, 30)
        companyNameTxt.frame = CGRectMake(16, 339, theWidth-32, 30)
        signupBtn.center = CGPointMake(theWidth/2, 400)
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.barTintColor  = UIColor(red: 0.141, green: 0.153, blue: 0.212, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.808, green: 0.824, blue: 0.831, alpha: 1.0)
        let logo = UIImage(named: "logo_small.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // allows user to select image for profile
    @IBAction func addImgBtn_click(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        self.presentViewController(image, animated: true, completion: nil)
    }

    // assigns chosen image to profile image var
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        profileImg.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // returns from keyboard input on text fields
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        profileNameTxt.resignFirstResponder()
        return true
    }

    // returns from keyboard when click away from keyboard
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    // makes keyboard not cover input area
    func textFieldDidBeginEditing(textField: UITextField) {
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if (UIScreen.mainScreen().bounds.height == 568) {
            if (textField == self.profileNameTxt || textField == self.companyNameTxt) {
                UIView.animateWithDuration(0.3, delay: 0, options:.CurveLinear, animations: {
                    self.view.center = CGPointMake(theWidth/2, (theHeight/2)-90)
                    }, completion: {
                        (finished:Bool) in
                        //
                })
            }
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if (UIScreen.mainScreen().bounds.height == 568) {
            if (textField == self.profileNameTxt) {
                UIView.animateWithDuration(0.3, delay: 0, options:.CurveLinear, animations: {
                    self.view.center = CGPointMake(theWidth/2, (theHeight/2))
                    }, completion: {
                        (finished:Bool) in
                        //
                })
            }
        }
    }
    
    @IBAction func signupBtn_click(sender: AnyObject) {
        // TODO handle when there is no input data (or not enough)
        var user = PFUser()
        user.username = usernameTxt.text
        user.password = passwordTxt.text
        user.email = usernameTxt.text
        user["profileName"] = profileNameTxt.text
        user["company"] = companyNameTxt.text
        var email = split(usernameTxt.text) {$0 == "@"}
        user["domain"] = email[1]
        
        let imageData = UIImagePNGRepresentation(self.profileImg.image)
        let imageFile = PFFile(name:"profilePhoto.png", data: imageData)
        user["photo"] = imageFile
        
        user.signUpInBackgroundWithBlock {
            (succeeded:Bool, signUpError:NSError?) -> Void in
            if signUpError == nil {
                println("signup")
            } else {
                println("can't signup")
            }
        }
        
        var rating = PFObject(className: "Rating")
        rating["username"] = self.usernameTxt.text
        rating["score"] = 1
        rating["raters"] = 1
        rating.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("rating made")
                self.performSegueWithIdentifier("goToLoginVC", sender: self)
            } else {
                println("can't make rating")
            }
        }
    }    
}
