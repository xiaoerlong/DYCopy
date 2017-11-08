//
//  DYLivingChannelModel.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/10/16.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit
import ObjectMapper

class DYLivingChannelModel: Mappable {
    var cate_name: String?      // 分类
    var short_name: String?     // 短命名
    var cate_id: String?        // id
    
<<<<<<< HEAD

    
=======
>>>>>>> origin/master
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cate_id         <- map["cate_id"]
        short_name      <- map["short_name"]
        cate_name       <- map["cate_name"]
    }
}

class DYLivingChannelModelData: Mappable {
    
    var error: Int = 0
    var data: [DYLivingChannelModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error       <- map["error"]
        data        <- map["data"]
    }
}
