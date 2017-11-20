//
//  DYBarrageView.swift
//  DYCopy
//
//  Created by Tronsis－mac on 2017/11/20.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYBarrageView: UIView {
    // 弹幕状态
    enum MoveStatus {
        case start, enter, end
    }
    let padding: CGFloat = 10
    // 弹道
    var trajectory = 0
    // 弹幕状态回调
    var moveStatusBlock: ((MoveStatus) -> ())?
    // 弹幕label
    fileprivate var commentLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    // 指定构造器
    init(comment: String) {
        super.init(frame: CGRect.zero)
        setupSelf(comment)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DYBarrageView {
    // 初始化
    fileprivate func setupSelf(_ comment: String) {
        self.backgroundColor = UIColor.red
        commentLabel.text = comment
        commentLabel.sizeToFit()
        self.bounds = CGRect.init(x: 0, y: 0, width: commentLabel.frame.width + 2 * padding, height: 30)
        commentLabel.frame = CGRect.init(x: padding, y: 0, width: commentLabel.frame.width, height: 30)
        self.addSubview(commentLabel)
    }
}

extension DYBarrageView {
    // 开始动画
    func startAnimation() {
        let screenWidth = UIScreen.main.bounds.width
        let duration: CGFloat = 4.0
        let wholeWidth = screenWidth + self.bounds.width
        
        guard let moveStatusBlock = moveStatusBlock else { return }
        // 开始进入
        moveStatusBlock(.start)
        
        // 开始进入到完全进入
        let speed = wholeWidth / duration
        let enterDuration = self.bounds.width / speed
        self.perform(#selector(enterScreen), with: nil, afterDelay: TimeInterval(enterDuration))
        
        // 移动动画
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: .curveLinear, animations: {
            self.frame.origin.x -= wholeWidth
        }) { (finished) in
            moveStatusBlock(.end)
        }
    }
    
    // 结束动画
    func stopAnimation() {
        self.layer.removeAllAnimations()
        self.removeFromSuperview()
    }
    
    @objc fileprivate func enterScreen() {
        guard let moveStatusBlock = moveStatusBlock else { return }
        moveStatusBlock(.enter)
    }
}
