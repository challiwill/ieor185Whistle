//
//  thankYouVC.swift
//  ChatApp
//
//  Created by Black_Shark on 4/29/15.
//  Copyright (c) 2015 Black_Shark. All rights reserved.
//

import UIKit

class thankYouVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.hidesBackButton = false
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
    

}
