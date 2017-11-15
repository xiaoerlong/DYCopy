//
//  DYNormalCollectionViewCell.swift
//  DYCopy
//
//  Created by Tronsis－mac on 17/6/26.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit
import Kingfisher

class DYNormalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var roomnameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    
    @IBOutlet weak var numBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupNumViewBackground()
        
    }
    
}

extension DYNormalCollectionViewCell {
    // 设置观看人数背景
    fileprivate func setupNumViewBackground() {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.0).cgColor, UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor]
        gradientLayer.locations = [NSNumber.init(value: 0), NSNumber.init(value: 1)]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0)
        gradientLayer.frame = self.numBackgroundView.bounds
        self.numBackgroundView.layer.addSublayer(gradientLayer)
    }
    
    // 计算观看人数
    private func calculatePersons(online: Int) -> String? {
        let persons: String?
        if online > 10000 {
            persons = "\(online/10000)万"
        } else {
            persons = "\(online)"
        }
        return persons
    }
    
    // 设置cell
    func configureInfo(model: DYLivingDataModel) {
        roomnameLabel.text = model.room_name
        nicknameLabel.text = model.nickname
        onlineLabel.text = calculatePersons(online: model.online)
        let url = URL.init(string: model.room_src!)
        backgroundImageView.kf.setImage(with: url)
    }
}
