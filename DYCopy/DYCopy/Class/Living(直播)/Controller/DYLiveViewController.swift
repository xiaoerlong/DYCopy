//
//  DYLiveViewController.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/7/12.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit
<<<<<<< HEAD
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




=======

private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (APP_SCREEN_WIDTH - 3 * kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4

private let normalIdentifier = "NormalCollectionCell"

class DYLiveViewController: UIViewController {
    
    // 数据
    var dataArray: [DYLivingDataModel] = Array.init()

    //MARK: lzay init
    lazy var collectionView: UICollectionView = {
        // 1.创建布局
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = kItemMargin
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - TabbarHeight - StatusBarHeight - NavigationBarHeight), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(_ : UINib.init(nibName: "DYNormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: normalIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        DYBaseNetworkTool.getAllLivingData(limit: 10, offset: 0) { (model) in
            if model?.error == 0 {
                // success
                self.dataArray = (model?.data!)!
                self.collectionView.reloadData()
            }
        }
    }
}

extension DYLiveViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalIdentifier, for: indexPath) as! DYNormalCollectionViewCell
        cell.configureInfo(model: dataArray[indexPath.row])
        return cell
    }
}

extension DYLiveViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: kItemW, height: kNormalItemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playVC = DYPlayViewController()
        let model = dataArray[indexPath.row]
        playVC.jumpURLString =  model.jumpUrl
        playVC.room_id = model.room_id
        self.navigationController?.pushViewController(playVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: kItemMargin, bottom: 5, right: kItemMargin)
    }
}
>>>>>>> origin/master

