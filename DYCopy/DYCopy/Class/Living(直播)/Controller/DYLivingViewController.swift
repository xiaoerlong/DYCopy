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
        
        getGameCategory()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.`default`
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}


extension DYLivingViewController {
    // 获取游戏分类
    fileprivate func getGameCategory() {

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

    // 添加标题和内容
    private func addContent(titles: Array<String>) {

        let configuration = XEL_Configuration.init()
        configuration.titleViewHeight = NavigationBarHeight
        configuration.titleViewScrollEable = true
        configuration.defaultIndex = 1
        configuration.titlesArray = ["常用", "全部"] + titles
        var controllersArray = [UIViewController]()

        
        for i in 0..<configuration.titlesArray.count {
            if i == 0 || i == 1 || i == 3 || i == 7 || i == 10 {
                let controller = DYLiveViewController()
                controllersArray.append(controller)
            } else {
                let controller = DYLivingGameViewController()
                controller.short_name = self.modelArray[i-2].short_name!
                controller.cate_id = self.modelArray[i-2].cate_id!
                controllersArray.append(controller)
            }
        }
        
        
        configuration.controllersArray = controllersArray

        
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

