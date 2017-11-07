//
//  DYLivingDataModel.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/10/16.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit
import ObjectMapper

class DYLivingDataModel: Mappable {
    var room_id: String?            // 房间ID
    var room_src: String?           // 地址
    var room_name: String?          // 房间名
    var online: Int = 0             // 在线人数
    var nickname: String?           // 主播名
    var jumpUrl: String?            // 跳转URL
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        room_id         <- map["room_id"]
        room_src        <- map["room_src"]
        room_name       <- map["room_name"]
        online          <- map["online"]
        nickname        <- map["nickname"]
        jumpUrl         <- map["jumpUrl"]
    }
}

class DYLivingData: Mappable {
    var error: Int = 0
    var data: [DYLivingDataModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error       <- map["error"]
        data        <- map["data"]
    }
    
}
