//
//  DYCategoryTableViewCell.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/4/16.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit


class DYCategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rankButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var livingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        rankButton.set(image: #imageLiteral(resourceName: "homeNewItem_rankingList"), title: "排行榜", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        messageButton.set(image: #imageLiteral(resourceName: "homeNewItem_msg"), title: "消息", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        activityButton.set(image: #imageLiteral(resourceName: "homeNewItem_Activity"), title: "活动", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        livingButton.set(image: #imageLiteral(resourceName: "homeNewItem_allLive"), title: "全部直播", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override var frame: CGRect {
//        didSet {
//            
//        }
//    }
    
}
