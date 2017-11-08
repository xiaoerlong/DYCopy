//
//  PullDownView.swift
//  PullDownView
//
//  Created by Tronsis－mac on 17/10/23.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

import UIKit

/*
 说明：创建一个下拉菜单，有一个下拉按钮和一个collectionview，collectionview每行有4个cellItem，按钮是外延到view的，不可以滚动
 */
class PullDownView: UIView {

    private var showComplete = false // 是否显示完全 true：显示完全 false：未显示完全
    var titlesArray = Array<String>()
    let itemHeight: CGFloat = 30.0
    let buttonHeight: CGFloat = 20.0
    let padding: CGFloat = 10
    let horizontalItemCount: Int = 4
    var height: CGFloat = 0 // 默认高度
    
    var collectionView: UICollectionView?
    var pullButton: UIButton?
    var arrowImageView: UIImageView?
    
    var delegate: PullDownViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        height = (padding + itemHeight) + padding + buttonHeight
    }
    
    init(frame: CGRect, titlesArray: Array<String>) {
        super.init(frame: frame)
        self.titlesArray = titlesArray
        height = (padding + itemHeight) + padding + buttonHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    // 初始化UI
    func setupUI() {
        self.frame.size.height = height
        let collectionViewFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.frame.width, height: height - buttonHeight))
        let pullButtonFrame = CGRect.init(x: 0, y: height - buttonHeight, width: self.frame.width, height: buttonHeight)
        if self.collectionView == nil {
            let collectionViewLayout = UICollectionViewFlowLayout.init()
            collectionViewLayout.itemSize = CGSize.init(width: (self.frame.width - CGFloat(horizontalItemCount + 1) * padding) / CGFloat(horizontalItemCount), height: itemHeight)
            collectionViewLayout.minimumLineSpacing = padding
            collectionViewLayout.minimumInteritemSpacing = padding
            collectionViewLayout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding)
            let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
            collectionView.backgroundColor = UIColor.white
            collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
            collectionView.dataSource = self
            collectionView.delegate = self
            self.addSubview(collectionView)
            self.collectionView = collectionView
        }
        self.collectionView?.frame = collectionViewFrame
        
        if self.pullButton == nil {
            let pullButton = UIButton.init(type: .custom)
            pullButton.frame = CGRect.zero
            pullButton.setImage(#imageLiteral(resourceName: "footTypeBase"), for: .normal)
            pullButton.adjustsImageWhenHighlighted = false
            pullButton.addTarget(self, action: #selector(pullDown), for: .touchUpInside)
            self.addSubview(pullButton)
            self.pullButton = pullButton
            
            let imageView = UIImageView.init(image: #imageLiteral(resourceName: "btn_drop"))
            imageView.center = pullButton.center
            self.addSubview(imageView)
            self.bringSubview(toFront: imageView)
            self.arrowImageView = imageView
        }
        self.pullButton?.frame = pullButtonFrame
        self.arrowImageView?.center = CGPoint.init(x: (self.pullButton?.center.x)!, y: (self.pullButton?.center.y)! - 3)
    }
    
    // 显示或者收起菜单
    func pullDown(btn: UIButton) {
        showComplete = !showComplete
        self.arrowImageView?.transform = showComplete ? CGAffineTransform.init(rotationAngle: CGFloat.pi) : CGAffineTransform.identity
        let lineCount = showComplete ? ceil(Double(titlesArray.count) / Double(horizontalItemCount)) : 1
        height = (itemHeight + padding) * CGFloat(min(lineCount, 6)) + padding + buttonHeight
        if let delegate = delegate {
            delegate.pullButtonDidSelect(height: height)
        }
        self.setNeedsLayout()
    }
}

extension PullDownView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titlesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if (cell.contentView.subviews.count != 0) {
            while self.subviews.count > 0 {
                self.subviews.last?.removeFromSuperview()
            }
        }
        let label = UILabel.init(frame: cell.contentView.bounds)
        label.text = titlesArray[indexPath.row]
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(red: 133/255, green: 133/255, blue: 133/255, alpha: 1)
        label.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        label.clipsToBounds = true
        label.layer.cornerRadius = label.frame.height / 2
        cell.contentView.addSubview(label)
        
        return cell
    }
}

protocol PullDownViewDelegate {
    func pullButtonDidSelect(height: CGFloat)
}

