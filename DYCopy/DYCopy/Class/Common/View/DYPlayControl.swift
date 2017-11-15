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
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fullButton: UIButton!
    @IBOutlet weak var overlayPanel: UIView!
    
}

extension DYPlayControl {
    func playControl() {
        self.playButton.isSelected = !self.playButton.isSelected
        if self.playButton.isSelected { // 暂停
            delegatePlayer?.stop()
        } else { // 播放
            delegatePlayer?.play()
        }
    }
    
    // 全屏
    func fullControl() {
        self.fullButton.isSelected = !self.fullButton.isSelected
        if self.fullButton.isSelected { // 全屏
            
        } else { // 半屏
            
        }
    }
    
    // 显示或者隐藏
    func showNoFade() {
        self.overlayPanel.isHidden = false
        cancelDelayedHide()
    }
    
    func showAndFade() {
        showNoFade()
        self.perform(#selector(hide), with: nil, afterDelay: 5)
    }
    
    func hide() {
        self.overlayPanel.isHidden = true
        cancelDelayedHide()
    }
    
    private func cancelDelayedHide() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hide), object: nil)
    }
}
