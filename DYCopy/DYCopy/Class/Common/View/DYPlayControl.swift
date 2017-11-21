//
//  DYPlayControl.swift
//  DYCopy
//
//  Created by Tronsis－mac on 2017/11/15.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYPlayControl: UIControl {

    var delegatePlayer: IJKMediaPlayback?
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}



extension DYPlayControl {
    func playControl(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected { // 暂停
            delegatePlayer?.stop()
        } else { // 播放
            delegatePlayer?.play()
        }
    }
    
    
    
    // 全屏
    func fullControl(_ btn: UIButton) {
        // 当前屏幕方向
        let currentOrientation = UIDevice.current.orientation
        // 目标屏幕方向
        var orientationTarget: NSNumber = NSNumber.init(value: Int8(currentOrientation.rawValue))
        if currentOrientation == UIDeviceOrientation.portrait {
            orientationTarget = NSNumber.init(value: Int8(UIDeviceOrientation.landscapeLeft.rawValue))
        } else if currentOrientation == UIDeviceOrientation.landscapeLeft {
            orientationTarget = NSNumber.init(value: Int8(UIDeviceOrientation.portrait.rawValue))
        }
        UIDevice.current.setValue(orientationTarget, forKey: "orientation")
    }
    
    // 显示或者隐藏
    func showNoFade(_ overlayPanel: UIView) {
        overlayPanel.isHidden = false
        cancelDelayedHide()
    }
    
    func showAndFade(_ overlayPanel: UIView) {
        showNoFade(overlayPanel)
        self.perform(#selector(hide), with: nil, afterDelay: 5)
    }
    
    func hide(_ overlayPanel: UIView) {
        overlayPanel.isHidden = true
        cancelDelayedHide()
    }
    
    private func cancelDelayedHide() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hide), object: nil)
    }
}
