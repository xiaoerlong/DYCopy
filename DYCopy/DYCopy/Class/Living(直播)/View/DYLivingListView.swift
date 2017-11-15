//
//  DYLivingListView.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/10/30.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (APP_SCREEN_WIDTH - 3 * kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4

private let normalIdentifier = "NormalCollectionCell"

class DYLivingListView: UIView {
    
    public var dataArray: [DYLivingDataModel]?
    public var viewController: UIViewController?


    //MARK: lzay init
    lazy var collectionView: UICollectionView = {
        // 1.创建布局
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = kItemMargin
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(_ : UINib.init(nibName: "DYNormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: normalIdentifier)
        return collectionView
    }()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    init(frame: CGRect, dataArray: [DYLivingDataModel]?) {

        super.init(frame: frame)
        self.addSubview(collectionView)
        self.dataArray = dataArray
        self.collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DYLivingListView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataArray = dataArray {
            return dataArray.count
        }
        return 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalIdentifier, for: indexPath) as! DYNormalCollectionViewCell

        if let dataArray = dataArray {
            cell.configureInfo(model: dataArray[indexPath.row])
        }

        return cell
    }
}

extension DYLivingListView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: kItemW, height: kNormalItemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playVC = DYPlayViewController()
        let model = dataArray![indexPath.row]
        playVC.jumpURLString =  model.jumpUrl
        playVC.room_id = model.room_id
        viewController?.navigationController?.pushViewController(playVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: kItemMargin, bottom: 5, right: kItemMargin)
    }
}



