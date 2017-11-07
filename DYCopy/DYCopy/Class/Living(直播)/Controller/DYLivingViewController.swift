//
//  DYLivingViewController.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/5/14.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYLivingViewController: UIViewController {

    var bridge: Xel_Bridge?
    var modelArray = [DYLivingChannelModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        
        // 获取游戏分类
        DYBaseNetworkTool.getColumnList { (modelData) in
            if let modelData = modelData {
                if modelData.error == 0 {
                    self.modelArray = modelData.data!
                    var titlesArray = [String]()
                    for model in modelData.data! {
                        titlesArray.append(model.cate_name!)
                    }
                    self.addContent(titles: titlesArray)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.`default`
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // 添加标题和内容
    func addContent(titles: Array<String>) {
        let configuration = XEL_Configuration.init()
        configuration.titleViewHeight = NavigationBarHeight
        configuration.titleViewScrollEable = true
        configuration.defaultIndex = 1
        configuration.titlesArray = ["常用", "全部"] + titles
        var controllersArray = [UIViewController]()
        for i in 1...8 {
            let gameVC = DYLivingGameViewController()
            gameVC.short_name = self.modelArray[i-1].short_name!
            gameVC.cate_id = self.modelArray[i-1].cate_id!
            controllersArray.append(gameVC)
        }
        
        
        configuration.controllersArray = [DYLiveViewController(), DYLiveViewController(), controllersArray[0], DYLiveViewController(), controllersArray[1], controllersArray[2], controllersArray[3], controllersArray[4], controllersArray[5], controllersArray[6], controllersArray[7]]
        
        let titleView = XEL_ContainerTitleView.init(frame: CGRect.init(x: 0.0, y: StatusBarHeight, width: APP_SCREEN_WIDTH, height: NavigationBarHeight))
        titleView?.configuration = configuration
        let contentView = XEL_ContainerContentView.init(frame: CGRect.init(x: 0, y: StatusBarHeight + NavigationBarHeight, width: APP_SCREEN_WIDTH, height: APP_SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight - TabbarHeight),parentController: self)
        contentView?.configuration = configuration
        
        bridge = Xel_Bridge.init(titleView: titleView, contentView: contentView)
        bridge?.connect()
        
        self.view.addSubview(titleView!)
        self.view.addSubview(contentView!)
    }
}

