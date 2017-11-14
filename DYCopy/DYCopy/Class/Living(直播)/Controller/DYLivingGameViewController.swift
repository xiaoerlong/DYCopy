//
//  DYLivingGameViewController.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/10/18.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYLivingGameViewController: UIViewController {

    public var short_name: String = ""
    public var cate_id: String = ""
    
    var pullView = PullDownView()
    var livingListView = DYLivingListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCategory()
        
        getList()
        
    }
}

extension DYLivingGameViewController {
    // 获取分类
    fileprivate func getCategory() {

        DYBaseNetworkTool.getColumnDetial(shortName: short_name) { (modelData) in
            var temp = Array<String>()
            for model in (modelData?.data)! {
                temp.append(model.tag_name!)
            }
            self.pullView = PullDownView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 0), titlesArray: temp)
            self.pullView.delegate = self
            self.view.addSubview(self.pullView)
        }

    }
    
    // 获取分类下的直播列表
    fileprivate func getList() {

        DYBaseNetworkTool.getColumnRoom(cate_id: cate_id, limit: 20, offset: 0) { (data) in
            self.livingListView = DYLivingListView.init(frame: CGRect.init(x: 0, y: self.pullView.height, width: self.view.frame.width, height: self.view.frame.height - self.pullView.height), dataArray: data.data!)
            self.livingListView.viewController = self
            self.view.addSubview(self.livingListView)
        }

    }
}

extension DYLivingGameViewController: PullDownViewDelegate {
    func pullButtonDidSelect(height: CGFloat) {
        self.livingListView.frame.origin.y = height
    }
}
