//
//  DYHomeHeaderView.swift
//  DYCopy
//
//  Created by Tronsis－mac on 17/5/8.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYHomeHeaderView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let identifier: String = "HomeHeaderCollectionViewCell"
    
    public var itemTitlessArray = [["王者荣耀", "天天狼人杀", "新游中心", "弹弹堂",
                            "阴阳师", "火影忍者", "球球大作战", "狼人杀世界",],
                            ["王者荣耀1", "天天狼人杀1", "新游中心", "弹弹堂",
                             "阴阳师", "火影忍者1", "球球大作战", "狼人杀世界",],
                            ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib.init(nibName: "DYHomeHeaderViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension DYHomeHeaderView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return itemTitlessArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemTitlessArray[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DYHomeHeaderViewCollectionViewCell
        cell.itemTitleLabel.text = itemTitlessArray[indexPath.section][indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: APP_SCREEN_WIDTH / 4, height: collectionView.frame.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension DYHomeHeaderView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = NSInteger(scrollView.contentOffset.x / scrollView.frame.width)
    }
}
