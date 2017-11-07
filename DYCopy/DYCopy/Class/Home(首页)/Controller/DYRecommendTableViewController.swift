//
//  DYRecommendTableViewController.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/4/13.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit
import SDCycleScrollView


private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (APP_SCREEN_WIDTH - 3 * kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kCycleViewH: CGFloat = 200
private let kCategoryViewH: CGFloat = 80

private let normalCellIdentifier = "cell"

private let normalIdentifier = "NormalCollectionCell"
private let prettyIdentifier = "PrettyCollectionCell"
private let kHeaderViewID = "RecommendHeaderView"

private let itemW: CGFloat = 100
private let itemH: CGFloat = 50
private let rightMargin: CGFloat = 15

class DYRecommendTableViewController: UIViewController {
    
    let buttonPadding: CGFloat = 10
    let buttonWidthHeight: CGFloat = 50
    let animateDuration = 0.2
    private var addButton: UIButton?
    private var maskView: UIView?
    
    let itemImages = [#imageLiteral(resourceName: "btn_yuyin_home"), #imageLiteral(resourceName: "btn_video_home"), #imageLiteral(resourceName: "btn_note_home"), #imageLiteral(resourceName: "btn_gamelive_home"),#imageLiteral(resourceName: "btn_live_home")]
    let itemTitles: [String?] = ["语音开黑", "发布视频", "发布动态", "手游直播", "摄像直播"]
    var itemsArray: [UIButton]? = Array.init()
    
    //MARK: lzay init
    lazy var collectionView: UICollectionView = {
        // 1.创建布局
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = kItemMargin
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 49 - 64 - 50), collectionViewLayout: layout)
        print(self.view.frame.height)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(_ : UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: normalCellIdentifier)
        collectionView.register(_ : UINib.init(nibName: "DYNormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: normalIdentifier)
        collectionView.register(_ : UINib.init(nibName: "DYPrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: prettyIdentifier)
        collectionView.register(_ : UINib.init(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    lazy var cycleView: SDCycleScrollView = {
        let cycleScrollView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: APP_SCREEN_WIDTH, height: kCycleViewH), imageNamesGroup: [UIImage.init(named: "IMG_0111")!,
                                                                                          UIImage.init(named: "IMG_0112")!,
                                                                                          UIImage.init(named: "IMG_0113")!])
        
        
        cycleScrollView?.autoScrollTimeInterval = 3
        return cycleScrollView!
    }()
    
    lazy var categoryView: DYRecommendCategoryView = {
        let categoryView = Bundle.main.loadNibNamed("DYRecommendCategoryView", owner: nil, options: nil)?.first as! DYRecommendCategoryView
        categoryView.frame = CGRect.init(x: 0, y: 0, width: APP_SCREEN_WIDTH, height: kCategoryViewH)
        return categoryView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        let popBtn = XELPopButton.init(frame: CGRect.init(x: APP_SCREEN_WIDTH - buttonPadding - buttonWidthHeight, y: APP_SCREEN_HEIGHT - buttonPadding - buttonWidthHeight - 64, width: buttonWidthHeight, height: buttonWidthHeight))
        popBtn.titlesArray = ["语音开黑", "发布视频", "发布动态", "手游直播", "摄像直播"]
        popBtn.imagesArray = [#imageLiteral(resourceName: "btn_yuyin_home"), #imageLiteral(resourceName: "btn_video_home"), #imageLiteral(resourceName: "btn_note_home"), #imageLiteral(resourceName: "btn_gamelive_home"),#imageLiteral(resourceName: "btn_live_home")]
        popBtn.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        view.addSubview(popBtn)
        view.bringSubview(toFront: popBtn)
    }
    
    func showMenu(btn: XELPopButton) -> Void {
        btn.show { (index) in
            
        }
    }
}

//MARK: UICollectionViewDataSource
extension DYRecommendTableViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else if section == 3 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            // 轮播图
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellIdentifier, for: indexPath)
            cell.contentView.addSubview(cycleView)
            return cell
        } else if indexPath.section == 1 {
            // 分类选项
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellIdentifier, for: indexPath)
            cell.contentView.addSubview(categoryView)
            return cell
        } else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyIdentifier, for: indexPath) as! DYPrettyCollectionViewCell
            
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

extension DYRecommendTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize.init(width: APP_SCREEN_WIDTH, height: kCycleViewH)
        } else if indexPath.section == 1 {
            return CGSize.init(width: APP_SCREEN_WIDTH, height: kCategoryViewH)
        } else if indexPath.section == 3 {
            return CGSize.init(width: kItemW, height: kPrettyItemH)
        }
        return CGSize.init(width: kItemW, height: kNormalItemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 1 {
            return CGSize.zero
        } else {
            return CGSize.init(width: APP_SCREEN_WIDTH, height: kHeaderViewH)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 || section == 1 {
            return UIEdgeInsets.zero
        }
        return UIEdgeInsets.init(top: 5, left: kItemMargin, bottom: 5, right: kItemMargin)
    }
}

