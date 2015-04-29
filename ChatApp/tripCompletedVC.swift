//
//  tripCompletedVC.swift
//  ChatApp
//
//  Created by Black_Shark on 4/13/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit

var otherImg:UIImage? = UIImage()

class tripCompletedVC: UIViewController {

    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var otherUserImg: UIImageView!
    @IBOutlet weak var otherUserLbl: UILabel!
    @IBOutlet weak var qMarkLbl: UILabel!
    
    var feltSafe:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        TODO set relative positioning
        self.otherUserLbl.text = otherProfileName
        self.otherUserImg.image = otherImg
        self.otherUserImg.layer.cornerRadius = self.otherUserImg.frame.size.width/2
        self.otherUserImg.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.barTintColor  = UIColor(red: 0.141, green: 0.486, blue: 0.671, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.808, green: 0.824, blue: 0.831, alpha: 1.0)
        let logo = UIImage(named: "logo_small_light.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
    
    @IBAction func yesBtn_click(sender: UIButton) {
        noBtn.selected = false
        sender.selected = true
        feltSafe = 1
    }
    
    @IBAction func noBtn_click(sender: UIButton) {
        yesBtn.selected = false
        sender.selected = true
        feltSafe = 0
    }
    
    
}
