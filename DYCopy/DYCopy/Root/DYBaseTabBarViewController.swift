//
//  DYBaseTabBarViewController.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/4/16.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYBaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = SYSTEM_COLOR
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
