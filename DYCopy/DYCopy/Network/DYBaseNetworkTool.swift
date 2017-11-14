//
//  DYBaseNetworkTool.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/10/15.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper


protocol NetworkToolProtocol {
    /// 获取当前全部直播
    static func getAllLivingData(limit: Int, offset: Int, completionHandler:@escaping (_ result: DYLivingData?)->())
    /// 获取父频道
    static func getColumnList(completionHandle:@escaping(_ result: DYLivingChannelModelData?)->())
    /// 获取子频道
    static func getColumnDetial(shortName: String, completionHandler:@escaping (_ result: DYLivingSubChannelModelData?)->())
    /// 获取父频道所有直播列表
    static func getColumnRoom(cate_id: String, limit: Int, offset: Int, completionHandler:@escaping(_ result: DYLivingData)->())
    /// 获取子频道所有直播列表
    static func getSubColumnRoom(tag_id: String, limit: Int, offset: Int, completionHandle:@escaping(_ result: DYLivingData)->())
    /// 获取房间信息
    static func getRoomDetial(room_id: String, completionHandle:@escaping(_ result: DYLivingData)->())
}



class DYBaseNetworkTool: NetworkToolProtocol {
    /// 获取当前全部直播
    class func getAllLivingData(limit: Int, offset: Int, completionHandler: @escaping (DYLivingData?) -> ()) {
        let url = BASE_URL + "api/v1/live"
        let params = ["limit": limit,
                      "offset": offset] as [String : AnyObject]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                var data: DYLivingData?
                
                let json = JSON(value).dictionaryObject
                data = Mapper<DYLivingData>().map(JSON: json!)
                completionHandler(data)
            }
        }
    }
    
    /// 获取父频道
    class func getColumnList(completionHandle: @escaping (DYLivingChannelModelData?) -> ()) {
        let url = BASE_URL + "api/v1/getColumnList"
        Alamofire.request(url).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                var data: DYLivingChannelModelData?
                
                let json = JSON(value).dictionaryObject
                data = Mapper<DYLivingChannelModelData>().map(JSON: json!)
                completionHandle(data)
            }
        }
    }
    
    /// 获取子频道
    class func getColumnDetial(shortName: String, completionHandler: @escaping (DYLivingSubChannelModelData?) -> ()) {
        let url = BASE_URL + "api/v1/getColumnDetail"
        let params = ["shortName":shortName]
        
        Alamofire.request(url, parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                var data: DYLivingSubChannelModelData?
                
                let json = JSON(value).dictionaryObject
                data = Mapper<DYLivingSubChannelModelData>().map(JSON: json!)
                completionHandler(data)
            }
        }
    }
    
    /// 获取父频道所有直播列表
    class func getColumnRoom(cate_id: String, limit: Int, offset: Int, completionHandler:@escaping(_ result: DYLivingData)->()) {
        let url = BASE_URL + "api/v1/getColumnRoom/" + cate_id
        let params = ["limit": limit,
                      "offset": offset]
        
        Alamofire.request(url, parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                var data: DYLivingData?
                
                let json = JSON(value).dictionaryObject
                data = Mapper<DYLivingData>().map(JSON: json!)
                completionHandler(data!)
            }
        }
    }
    
    /// 获取子频道所有直播列表
    class func getSubColumnRoom(tag_id: String, limit: Int, offset: Int, completionHandle: @escaping (DYLivingData) -> ()) {
        let url = BASE_URL + "api/v1/live/" + tag_id
        let params = ["limit": limit,
                      "offset": offset]
        
        Alamofire.request(url, parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                var data: DYLivingData?
                
                let json = JSON(value).dictionaryObject
                data = Mapper<DYLivingData>().map(JSON: json!)
                completionHandle(data!)
            }
        }
    }
    
    /// 获取房间信息
    class func getRoomDetial(room_id: String, completionHandle: @escaping (DYLivingData) -> ()) {
        let timeStamp = Int(NSDate().timeIntervalSince1970)/1000

        let url = BASE_URL + "api/v1/room/" + room_id
        let params = ["aid": "android",
                      "client_sys": "android",
                      "time": "\(timeStamp)",
                      "auth": "room/\(room_id)?aid=android&clientsys=android&time=1231".md5()]
        

        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in

            debugPrint(response)
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                var data: DYLivingData?
                
                let json = JSON(value).dictionaryObject
                data = Mapper<DYLivingData>().map(JSON: json!)
                completionHandle(data!)
            }
        }
    }
}
