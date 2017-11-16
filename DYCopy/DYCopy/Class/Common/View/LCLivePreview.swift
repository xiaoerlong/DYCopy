//
//  LCLivePreview.swift
//  LiveCollect
//
//  Created by Tronsis－mac on 2017/11/14.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

import UIKit

class LCLivePreview: UIView {
    
    open var url: String?
    
    fileprivate lazy var session: LFLiveSession = {
        let audioConfigutation = LFLiveAudioConfiguration.default()
        let videoConfiguration = LFLiveVideoConfiguration.default()
        let session = LFLiveSession.init(audioConfiguration: audioConfigutation, videoConfiguration: videoConfiguration)!
        session.delegate = self
        session.preView = self
        return session
    }()
    
    fileprivate lazy var containerView: UIView = {
        let containerView = UIView.init(frame: self.bounds)
        containerView.backgroundColor = UIColor.clear
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return containerView
    }()
    
    fileprivate lazy var stateLabel: UILabel = {
        let stateLabel = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: 80, height: 40))
        stateLabel.text = "未连接"
        stateLabel.textColor = UIColor.white
        stateLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        return stateLabel
    }()
    
    fileprivate lazy var closeButton: UIButton = {
        let closeButton = UIButton.init()
        closeButton.frame.size = CGSize.init(width: 44, height: 44)
        closeButton.frame.origin.x = self.frame.size.width - 10 - closeButton.frame.size.width
        closeButton.frame.origin.y = 20
        closeButton.setImage(#imageLiteral(resourceName: "close_preview"), for: .normal)
        closeButton.isExclusiveTouch = true
        return closeButton
    }()
    
    fileprivate lazy var cameraButton: UIButton = {
        let cameraButton = UIButton.init()
        cameraButton.frame.size = CGSize.init(width: 44, height: 44)
        cameraButton.frame.origin = CGPoint.init(x: self.closeButton.frame.minX - 10 - cameraButton.frame.size.width, y: 20)
        cameraButton.setImage(#imageLiteral(resourceName: "camra_preview"), for: .normal)
        cameraButton.addTarget(self, action: #selector(changeCameraPosition), for: .touchUpInside)
        return cameraButton
    }()
    
    fileprivate lazy var beautyButton: UIButton = {
        let beautyButton = UIButton.init()
        beautyButton.frame.size = CGSize.init(width: 44, height: 44)
        beautyButton.frame.origin = CGPoint.init(x: self.cameraButton.frame.minX - 10 - beautyButton.frame.size.width, y: 20)
        beautyButton.setImage(#imageLiteral(resourceName: "camra_beauty"), for: .selected)
        beautyButton.setImage(#imageLiteral(resourceName: "camra_beauty_close"), for: .normal)
        beautyButton.isExclusiveTouch = true
        beautyButton.addTarget(self, action: #selector(openBeauty), for: .touchUpInside)
        return beautyButton
    }()
    
    fileprivate lazy var startLiveButton: UIButton = {
        let startLiveButton = UIButton.init()
        startLiveButton.frame.size = CGSize.init(width: self.frame.size.width - 60, height: 44)
        startLiveButton.frame.origin.x = 30
        startLiveButton.frame.origin.y = self.frame.size.height - 50 - startLiveButton.frame.size.height
        startLiveButton.layer.cornerRadius = startLiveButton.frame.size.height / 2
        startLiveButton.setTitleColor(UIColor.black, for: .normal)
        startLiveButton.setTitle("开始直播", for: .normal)
        startLiveButton.setTitle("结束直播", for: .selected)
        startLiveButton.backgroundColor = UIColor.init(red: 50, green: 32, blue: 245, alpha: 1)
        startLiveButton.isExclusiveTouch = true
        startLiveButton.addTarget(self, action: #selector(openLive), for: .touchUpInside)
        return startLiveButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        requestAccessForAudio()
        requestAccessForVideo()
        self.addSubview(containerView)
        containerView.addSubview(stateLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(cameraButton)
        containerView.addSubview(beautyButton)
        containerView.addSubview(startLiveButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension LCLivePreview {
    // 请求视频权限
    fileprivate func requestAccessForVideo() {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                if granted {
                    DispatchQueue.main.async {
                        self.session.running = true
                    }
                }
            })
            break
        case .authorized:
            session.running = true
        case .denied:
            fallthrough
        case .restricted:
            break;
        }
    }
    
    // 请求音频权限
    fileprivate func requestAccessForAudio() {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeAudio)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeAudio, completionHandler: { (granted) in
                
            })
            break
        case .authorized: break
        case .denied:
            fallthrough
        case .restricted: break
        }
    }
}

extension LCLivePreview {
    @objc fileprivate func changeCameraPosition() {
        let devicePosition = session.captureDevicePosition
        session.captureDevicePosition = (devicePosition == .back) ? .front : .back
    }
    
    @objc fileprivate func openBeauty(btn: UIButton) {
        session.beautyFace = btn.isSelected
        btn.isSelected = !btn.isSelected
    }
    
    @objc fileprivate func openLive(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            let stream = LFLiveStreamInfo.init()
            if let url = url {
                stream.url = url
                session.startLive(stream)
            }
        } else {
            session.stopLive()
        }
    }
}

extension LCLivePreview: LFLiveSessionDelegate {
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        switch state {
        case .ready:
            stateLabel.text = "未连接"
        case .pending:
            stateLabel.text = "连接中"
        case .start:
            stateLabel.text = "已连接"
        case .error:
            stateLabel.text = "连接错误"
        case .stop:
            stateLabel.text = "未连接"
        case .refresh:
            stateLabel.text = "刷新中"
        }
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        debugPrint("errorCode:\(errorCode)")
    }
}
