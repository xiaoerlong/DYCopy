//
//  DYLiveViewController.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/7/12.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

import ESPullToRefresh

class DYLiveViewController: UIViewController {
    
    var livingListView = DYLivingListView()
    var offset = 0
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        livingListView = DYLivingListView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64-49), dataArray: nil)
        self.view.addSubview(livingListView)
        
        
        getList(limit: limit, offset: offset)
        refresh()
        loadMore()
    }
}

extension DYLiveViewController {
    // 获取直播列表
    fileprivate func getList(limit: Int, offset: Int) {
        DYBaseNetworkTool.getAllLivingData(limit: limit, offset: offset) { (model) in
            if model?.error == 0 {
                // success
                self.livingListView.dataArray = (model?.data)!
                self.livingListView.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func refresh() {
        offset = 0
        let _ = self.livingListView.collectionView.es_addPullToRefresh {
            [unowned self] in
            DYBaseNetworkTool.getAllLivingData(limit: self.limit, offset: self.offset) { (model) in
                self.livingListView.collectionView.es_stopPullToRefresh()
                if model?.error == 0 {
                    // success
                    self.livingListView.dataArray = (model?.data)!
                    self.livingListView.collectionView.reloadData()
                }
            }
        }
    }
    
    fileprivate func loadMore() {
        offset += 10
        let _ = self.livingListView.collectionView.es_addInfiniteScrolling {
            [unowned self] in
            DYBaseNetworkTool.getAllLivingData(limit: self.limit, offset: self.offset) { (model) in
                self.livingListView.collectionView.es_stopLoadingMore()
                if model?.error == 0 {
                    // success
                    for perModel in (model?.data)! {
                        debugPrint(perModel.nickname)
                    }
                    self.livingListView.dataArray! += (model?.data)!
                    self.livingListView.collectionView.reloadData()
                }
            }
        }
    }
}




