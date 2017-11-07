//
//  DYFocusViewController.swift
//  DYCopy
//
//  Created by Tronsis－mac on 17/5/15.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYFocusViewController: UIViewController {
    
    
    var bridge: Xel_Bridge?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = XEL_Configuration.init()
        configuration.titleViewHeight = 44
        configuration.controllersArray = [DYLiveViewController()]
        configuration.titlesArray = ["直播", "关注"]
        
        let titleView = XEL_ContainerTitleView.init(frame: CGRect.init(x: 100, y: 20, width: APP_SCREEN_WIDTH - 2 * 100, height: 44))
        titleView?.configuration = configuration
        let contentView = XEL_ContainerContentView.init(frame: CGRect.init(x: 0, y: 64, width: APP_SCREEN_WIDTH, height: APP_SCREEN_HEIGHT - 64), parentController: self)
        
        bridge = Xel_Bridge.init(titleView: titleView, contentView: contentView)
        bridge?.connect()
        
        self.navigationController?.view.addSubview(titleView!)
        self.view.addSubview(contentView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.`default`
    }
}

