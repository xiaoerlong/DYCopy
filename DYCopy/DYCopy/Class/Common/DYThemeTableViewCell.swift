//
//  DYThemeTableViewCell.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/4/17.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

//首页不同类型的主题分类
//最热、颜值、英雄联盟。。。。

import UIKit

class DYThemeTableViewCell: UITableViewCell {

    @IBOutlet weak var themeImageView: UIImageView!
    @IBOutlet weak var themeTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let identifier = "BaseCollectionViewCell"
    let padding: CGFloat = 10.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(UINib.init(nibName: "DYBaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension DYThemeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (APP_SCREEN_WIDTH - 3 * padding) / 2, height: self.frame.size.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: padding, left: padding, bottom: padding, right: padding)
    }
}
