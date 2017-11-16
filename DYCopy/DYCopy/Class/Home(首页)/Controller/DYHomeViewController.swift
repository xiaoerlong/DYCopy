//
//  DYHomeViewController.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/4/10.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYHomeViewController: UIViewController {
    
    fileprivate let buttonPadding: CGFloat = 10
    fileprivate let buttonWidthHeight: CGFloat = 50
    
    fileprivate var recommend: DYRecommendTableViewController!
    fileprivate var mobileGame: DYMobileGameTableViewController!
    fileprivate var amuse: DYAmuseTableViewController!
    fileprivate var game: DYGameTableViewController!
    fileprivate var fun: DYFunTableViewController!
    fileprivate var popBtn: XELPopButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        setCustomNavigationBar()
        setupSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        addPopButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        popBtn?.removeFromSuperview()
    }
    
}

extension DYHomeViewController {
    //MARK: 设置导航栏
    fileprivate func setCustomNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        let barView = Bundle.main.loadNibNamed("DYHomeNavigationBar", owner: nil, options: nil)?.first as? UIView
        barView?.frame = CGRect.init(x: 0, y: 0, width: APP_SCREEN_WIDTH, height: 64)
        self.view.addSubview(barView!)
    }
    
    fileprivate func setupSubView() {
        recommend = DYRecommendTableViewController()
        mobileGame = DYMobileGameTableViewController()
        amuse = DYAmuseTableViewController()
        game = DYGameTableViewController()
        fun = DYFunTableViewController()
        
        var rect = self.view.bounds
        rect.origin.y = 64
        rect.size.height -= (64 + 49)
        
        let configuration = XEL_Configuration.init()
        configuration.sliderPadding = 5
        configuration.titlesArray = ["推荐", "手游", "娱乐", "游戏", "趣玩"]
        configuration.controllersArray = [recommend, mobileGame, amuse, game, fun]
        
        let container = XEL_Container.init(frame: rect, parentController: self, configuration: configuration)
        
        self.view.addSubview(container!)
    }
    
    fileprivate func addPopButton() {
        popBtn = XELPopButton.init(frame: CGRect.init(x: APP_SCREEN_WIDTH - buttonPadding - buttonWidthHeight, y: APP_SCREEN_HEIGHT - buttonPadding - buttonWidthHeight - 64, width: buttonWidthHeight, height: buttonWidthHeight))
        if let popBtn = popBtn {
            popBtn.titlesArray = ["语音开黑", "发布视频", "发布动态", "手游直播", "摄像直播"]
            popBtn.imagesArray = [#imageLiteral(resourceName: "btn_yuyin_home"), #imageLiteral(resourceName: "btn_video_home"), #imageLiteral(resourceName: "btn_note_home"), #imageLiteral(resourceName: "btn_gamelive_home"),#imageLiteral(resourceName: "btn_live_home")]
            popBtn.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
            popBtn.setImage(#imageLiteral(resourceName: "btn_livevideo_start_home"), for: .normal)
            UIApplication.shared.keyWindow?.addSubview(popBtn)
        }
    }
    
    @objc fileprivate func showMenu(btn: XELPopButton) -> Void {
        btn.show { (index) in
            if index == 4 { // 摄像直播
                self.navigationController?.pushViewController(DYAnchorViewController(), animated: true)
            }
        }
    }
}

