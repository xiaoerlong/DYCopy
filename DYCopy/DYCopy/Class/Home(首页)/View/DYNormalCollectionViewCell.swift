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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundImageView.clipsToBounds = true
        
    }
    
    public func configureInfo(model: DYLivingDataModel) {
        roomnameLabel.text = model.room_name
        nicknameLabel.text = model.nickname
        onlineLabel.text = calculatePersons(online: model.online)
        let url = URL.init(string: model.room_src!)
        backgroundImageView.kf.setImage(with: url)
    }

    // 计算观看人数
    func calculatePersons(online: Int) -> String? {
        let persons: String?
        if online > 10000 {
            persons = "\(online/10000)万"
        } else {
            persons = "\(online)"
        }
        return persons
    }
}
