//
//  DYHomeCategoryViewController.swift
//  DYCopy
//
//  Created by Tronsis－mac on 17/6/29.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

// 首页分类中的基类

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (APP_SCREEN_WIDTH - 3 * kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kCycleViewH: CGFloat = 237

private let normalCellIdentifier = "cell"

private let normalIdentifier = "NormalCollectionCell"
private let kHeaderViewID = "RecommendHeaderView"

//MARK: public
public var titlesArray = Array<Array<String>>.init()

class DYHomeCategoryViewController: UIViewController {
    
    //MARK: lzay init
    lazy var collectionView: UICollectionView = {
        // 1.创建布局
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 49 - 64 - 50), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(_ : UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: normalCellIdentifier)
        collectionView.register(_ : UINib.init(nibName: "DYNormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: normalIdentifier)
        collectionView.register(_ : UINib.init(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    lazy var homeHeaderView: DYHomeHeaderView = {
        let homeHeaderView = Bundle.main.loadNibNamed("DYHomeHeaderView", owner: nil, options: nil)?.first as! DYHomeHeaderView
        homeHeaderView.frame = CGRect.init(x: 0, y: 0, width: APP_SCREEN_WIDTH, height: kCycleViewH)
        homeHeaderView.itemTitlessArray = titlesArray
        return homeHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
    }
}

extension DYHomeCategoryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            // 分类
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellIdentifier, for: indexPath)
            cell.contentView.addSubview(homeHeaderView)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalIdentifier, for: indexPath) as! DYNormalCollectionViewCell
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! DYRecommendHeaderView
        return headerView
    }
}

extension DYHomeCategoryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize.init(width: APP_SCREEN_WIDTH, height: kCycleViewH)
        }
        return CGSize.init(width: kItemW, height: kNormalItemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        }
        return CGSize.init(width: APP_SCREEN_WIDTH, height: kHeaderViewH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets.zero
        }
        return UIEdgeInsets.init(top: 5, left: kItemMargin, bottom: 5, right: kItemMargin)
    }
}
