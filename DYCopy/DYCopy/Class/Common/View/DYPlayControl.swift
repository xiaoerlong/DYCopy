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
    var overlayPanel: UIView?
    var barrageManager: DYBarrageManager?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}



extension DYPlayControl {
    func playControl(_ btn: UIButton) {
        if let overlayPanel = overlayPanel {
            showAndFade(overlayPanel)
        }
        btn.isSelected = !btn.isSelected
        if btn.isSelected { // 暂停
            delegatePlayer?.stop()
        } else { // 播放
            delegatePlayer?.play()
        }
    }
    
    
    
    // 全屏
    func fullControl(_ btn: UIButton) {
        if let overlayPanel = overlayPanel {
            showAndFade(overlayPanel)
        }
        
        // 目标屏幕方向
        var orientationTarget: NSNumber = NSNumber.init(value: Int8(UIDevice.current.orientation.rawValue))
        if UIDevice.current.orientation.isPortrait {
            orientationTarget = NSNumber.init(value: Int8(UIDeviceOrientation.landscapeLeft.rawValue))
            barrageManager?.start()
        } else if UIDevice.current.orientation.isLandscape {
            orientationTarget = NSNumber.init(value: Int8(UIDeviceOrientation.portrait.rawValue))
            barrageManager?.stop()
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
        // 延时5秒执行
        self.perform(#selector(hide), with: nil, afterDelay: 5)
    }
    
    func hide() {
        self.overlayPanel?.isHidden = true
        cancelDelayedHide()
    }
    
    private func cancelDelayedHide() {
        // 取消已设置的延迟执行
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hide), object: nil)
    }
}
