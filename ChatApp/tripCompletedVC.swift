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

    @IBOutlet weak var otherUserImg: UIImageView!
    @IBOutlet weak var otherUserLbl: UILabel!
    @IBOutlet weak var yesNoBtn: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        TODO set relative positioning
        self.otherUserLbl.text = otherProfileName
        self.otherUserImg.image = otherImg
        self.otherUserImg.layer.cornerRadius = self.otherUserImg.frame.size.width/2
        self.otherUserImg.clipsToBounds = true
    }
    
    override func viewDidAppear(animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "endTrip") {
            tripPlanSource = 2
        }
    }
}
