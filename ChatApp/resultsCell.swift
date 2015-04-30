//
//  resultsCell.swift
//  ChatApp
//
//  Created by Black_Shark on 4/8/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit

class resultsCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var leavingInLbl: UILabel!
    @IBOutlet weak var ratingImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let theWidth = UIScreen.mainScreen().bounds.width
        
        contentView.frame = CGRectMake(0, 0, theWidth, 120)
        
        profileImg.center = CGPointMake(60, 60)
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        profileImg.clipsToBounds = true
        profileNameLbl.center = CGPointMake(230, 25)
        companyLbl.center = CGPointMake(230, 45)
        ratingImg.center = CGPointMake(200, 87)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
