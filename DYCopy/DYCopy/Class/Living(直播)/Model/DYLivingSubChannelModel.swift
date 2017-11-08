//
//  DYLivingSubChannelModel.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/10/16.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit
import ObjectMapper

class DYLivingSubChannelModel: Mappable {
    
    var tag_id: String?
    var short_name: String?
    var tag_name: String?
    var tag_introduce: String?
    var url: String?
    var icon_url: String?
    var count: Int = 0
    var count_ios: Int = 0
    var cate_id: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        tag_id          <- map["tag_id"]
        short_name      <- map["short_name"]
        tag_name        <- map["tag_name"]
        tag_introduce   <- map["tag_introduce"]
        url             <- map["url"]
        icon_url        <- map["icon_url"]
        count           <- map["count"]
        count_ios       <- map["count_ios"]
        cate_id         <- map["cate_id"]
    }
}

class DYLivingSubChannelModelData: Mappable {
    
    var error: Int = 0
    var data: [DYLivingSubChannelModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error       <- map["error"]
        data        <- map["data"]
    }
}

