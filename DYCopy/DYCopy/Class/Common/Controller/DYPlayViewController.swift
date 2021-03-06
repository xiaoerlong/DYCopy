//
//  DYPlayViewController.swift
//  DYCopy
//
//  Created by Tronsis－mac on 17/5/15.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

//视屏播放控制器

import UIKit
import BMPlayer

class DYPlayViewController: UIViewController {

    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var birefView: UIView!
    @IBOutlet var mediaControl: DYPlayControl!
    @IBOutlet weak var overlayPanel: UIControl!
    
    
    
    var jumpURLString: String?
    var room_id: String?
    fileprivate var player: IJKMediaPlayback?
    fileprivate var barrageManager: DYBarrageManager?
    // 记录当前屏幕是否是全屏
    fileprivate var isFullScreen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupPlayer()
        getRoomDetial()
        // 添加弹幕
        setupBarrageManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if let player = player {
            if player.isPlaying() == false {
                player.prepareToPlay()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player?.shutdown()
    }
    
    // 支持横竖屏
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    
    
    
    //MARK: Action
    @IBAction func onClickMediaControl(_ sender: UIView) {
        mediaControl.showAndFade(overlayPanel)
    }
    
    @IBAction func onClickOverlay(_ sender: UIView) {
        mediaControl.hide()
    }
    
    @IBAction func onClickPlay(_ sender: UIButton) {
        mediaControl.playControl(sender)
    }
    
    
    @IBAction func onClickFull(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let currentOrientation = UIDevice.current.orientation
        if currentOrientation == UIDeviceOrientation.portrait {
            isFullScreen = true
        } else {
            isFullScreen = false
        }
        mediaControl.fullControl(sender)
    }
    
    @IBAction func onClickBack(_ sender: UIButton) {
        if isFullScreen == false {
            self.navigationController?.popViewController(animated: true)
        } else {
            mediaControl.fullControl(sender)
            isFullScreen = false
        }
    }
    
    @IBAction func onClickBarrage(_ sender: UIButton) {
        mediaControl.showAndFade(overlayPanel)
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.barrageManager?.stop()
        } else {
            self.barrageManager?.start()
        }
    }
}



extension DYPlayViewController {
    // 设置页面
    fileprivate func setupView() {
        self.mediaControl.overlayPanel = self.overlayPanel
        let configuration = XEL_Configuration.init()
        configuration.controllersArray = [UIViewController.init()]
        configuration.titlesArray = ["聊天", "主播", "视频"]
        
        let container = XEL_Container.init(frame: birefView.bounds, parentController: self, configuration: configuration)
        birefView.addSubview(container!)
        
        mediaControl.showAndFade(overlayPanel)
    }
    
    // 获取房间信息
    fileprivate func getRoomDetial() {
        guard let room_id = room_id else { return debugPrint("room_id为空") }
        DYBaseNetworkTool.getRoomDetial(room_id: room_id) { (data) in
            
        }
    }
    
    // 设置IJKPlayer
    fileprivate func setupPlayer() {
        let url = URL.init(string: "rtmp://192.168.32.164:1935/live1/room")
        let options = IJKFFOptions.byDefault()
        options?.setFormatOptionIntValue(0, forKey: "auto_convert")
        player = IJKFFMoviePlayerController.init(contentURL: url, with: options)
        if let player = player {
            player.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            player.view.frame = self.playView.bounds
            self.playView.autoresizesSubviews = true
            self.playView.addSubview(player.view)
            self.playView.insertSubview(player.view, belowSubview: self.mediaControl)
            player.setPauseInBackground(true)
            player.scalingMode = .aspectFill
            player.shouldAutoplay = true
            
            self.mediaControl.delegatePlayer = self.player
        }
    }
    
    // 添加弹幕
    fileprivate func setupBarrageManager() {
        let dataSource = ["666", "主播真会玩", "起小点见", "色情主播，我报警啦"]
        self.barrageManager = DYBarrageManager.init(dataSource: dataSource)
        self.barrageManager?.generateViewBlock = { (barrageView) in
                self.addBarrageView(barrageView)
        }
        self.mediaControl.barrageManager = self.barrageManager
    }
    
    private func addBarrageView(_ barrageView: DYBarrageView) {
        let width = UIScreen.main.bounds.width
        barrageView.frame = CGRect.init(x: width, y: CGFloat(20 + barrageView.trajectory * 40), width: barrageView.frame.width, height: barrageView.frame.height)
        self.playView.addSubview(barrageView)
        self.playView.insertSubview(barrageView, belowSubview: mediaControl)
        
        barrageView.startAnimation()
    }
}
