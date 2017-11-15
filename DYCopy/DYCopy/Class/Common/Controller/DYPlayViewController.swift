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
    
    
    var jumpURLString: String?
    var room_id: String?
    fileprivate var player: IJKMediaPlayback?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupPlayer()
        getRoomDetial()
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
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    
    //MARK: Action
    @IBAction func onClickMediaControl(_ sender: Any) {
        mediaControl.showAndFade()
    }
    
    @IBAction func onClickOverlay(_ sender: Any) {
        mediaControl.hide()
    }
    
    @IBAction func onClickPlay(_ sender: Any) {
        mediaControl.playControl()
    }
    
    
    @IBAction func onClickFull(_ sender: Any) {
        mediaControl.fullControl()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DYPlayViewController {
    // 设置页面
    fileprivate func setupView() {
        let configuration = XEL_Configuration.init()
        configuration.controllersArray = [UIViewController.init()]
        configuration.titlesArray = ["弹幕", "主播", "视频"]
        
        let container = XEL_Container.init(frame: birefView.bounds, parentController: self, configuration: configuration)
        birefView.addSubview(container!)
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
            player.view.layer.borderColor = UIColor.red.cgColor
            player.view.layer.borderWidth = 1
            player.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            player.view.frame = self.playView.bounds
            self.playView.autoresizesSubviews = true
            self.playView.addSubview(player.view)
            player.setPauseInBackground(true)
            player.scalingMode = .aspectFill
            player.shouldAutoplay = true
            
            self.mediaControl.frame = self.playView.bounds
            self.playView.addSubview(self.mediaControl)
            self.mediaControl.delegatePlayer = self.player
        }
    }
}
