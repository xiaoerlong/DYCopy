//
//  DYRecommendCategoryView.swift
//  DYCopy
//
//  Created by Tronsis－mac on 17/6/26.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYRecommendCategoryView: UIView {

    @IBOutlet weak var rankButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var livingButton: UIButton!
    
    override func awakeFromNib() {
        rankButton.set(image: #imageLiteral(resourceName: "homeNewItem_rankingList"), title: "排行榜", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        messageButton.set(image: #imageLiteral(resourceName: "homeNewItem_msg"), title: "消息", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        activityButton.set(image: #imageLiteral(resourceName: "homeNewItem_Activity"), title: "活动", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        livingButton.set(image: #imageLiteral(resourceName: "homeNewItem_allLive"), title: "全部直播", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        
        super.awakeFromNib()
    }

}
