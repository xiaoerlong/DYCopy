//
//  DYBarrageManager.swift
//  DYCopy
//
//  Created by Tronsis－mac on 2017/11/20.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYBarrageManager: NSObject {
    var generateViewBlock: ((DYBarrageView) -> ())?
    
    // 弹幕数据来源
    var dataSource: [String]
    // 弹幕使用过程中的数组变量
    fileprivate var barrageComments = [String]()
    // 存储弹幕view的数组变量
    fileprivate var barrageViews = [DYBarrageView]()
    // 停止动画 true:动画已停止 falese:动画已开始
    fileprivate var bStopAnimation: Bool
    
    init(dataSource: [String]) {
        self.bStopAnimation = true
        self.dataSource = dataSource
    }
}

extension DYBarrageManager {
    // 开始
    func start() {
        if bStopAnimation == false {
            return
        }
        bStopAnimation = false
        
        barrageComments.removeAll()
        barrageComments.append(contentsOf: dataSource)
        initBarrageComment()
    }
    
    // 停止
    func stop() {
        if bStopAnimation {
            return
        }
        self.bStopAnimation = true
        for view in self.barrageViews {
            view.stopAnimation()
        }
        self.barrageViews.removeAll()
    }
    
    // 初始化弹幕
    fileprivate func initBarrageComment() {
        // 随机分配弹幕轨迹
        var trajectorys: [Int] = [0, 1, 2]
        for _ in 0..<trajectorys.count {
            // 从随机数中取出弹幕轨迹
            let index = Int(arc4random()) % (trajectorys.count)
            let trajectory = trajectorys[index]
            trajectorys.remove(at: index)
            
            // 从弹幕数组中逐一取出弹幕数据
            let comment = barrageComments.first
            barrageComments.remove(at: 0)
            
            // 创建弹幕view
            createBarrageView(comment, at: trajectory)
        }
    }
    
    // 创建弹幕view
    fileprivate func createBarrageView(_ comment: String?, at trajectory: Int) {
        // 动画停止后不再创建弹幕view
        if bStopAnimation {
            return
        }
        
        guard let comment = comment else { return }
        let barrageView = DYBarrageView.init(comment: comment)
        barrageView.trajectory = trajectory
        barrageViews.append(barrageView)
        barrageView.moveStatusBlock = { (status) in
            if self.bStopAnimation {
                return
            }
            switch status {
            case .start:
                self.barrageViews.append(barrageView)
            case .enter:
                let nextComment = self.nextComment()
                self.createBarrageView(nextComment, at: trajectory)
            case .end:
                if self.barrageViews.contains(barrageView) {
                    barrageView.stopAnimation()
                    if let index = self.barrageViews.index(of: barrageView) {
                        self.barrageViews.remove(at: index)
                    }
                    // 屏幕上没有弹幕
                    if self.barrageComments.count == 0 {
                        self.bStopAnimation = true
                        self.start()
                    }
                }
            }
        }
        if let block = self.generateViewBlock {
            block(barrageView)
        }
    }
    
    fileprivate func nextComment() -> String? {
        if self.barrageComments.count == 0 {
            return nil
        }
        let comment = self.barrageComments.first
        if let _ = comment {
            self.barrageComments.remove(at: 0)
        }
        return comment
    }
}
