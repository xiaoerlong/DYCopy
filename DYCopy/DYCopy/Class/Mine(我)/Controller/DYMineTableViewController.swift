//
//  DYMineTableViewController.swift
//  DYCopy
//
//  Created by Tronsis－mac on 17/5/8.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYMineTableViewController: UITableViewController {

    private let buttonPadding: CGFloat = 10
    private let buttonWidthHeight: CGFloat = 50
    
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var guizuButton: UIButton!
    @IBOutlet weak var withdrawButton: UIButton!
    
    private var popBtn: XELPopButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        self.layoutButton()
        
    }
    
    func showMenu(btn: XELPopButton) -> Void {
        btn.show { (index) in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        popBtn?.removeFromSuperview()
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        popBtn = XELPopButton.init(frame: CGRect.init(x: APP_SCREEN_WIDTH - buttonPadding - buttonWidthHeight, y: APP_SCREEN_HEIGHT - buttonPadding - buttonWidthHeight - 64, width: buttonWidthHeight, height: buttonWidthHeight))
        if let popBtn = popBtn {
            popBtn.titlesArray = ["语音开黑", "发布视频", "发布动态", "手游直播", "摄像直播"]
            popBtn.imagesArray = [#imageLiteral(resourceName: "btn_yuyin_home"), #imageLiteral(resourceName: "btn_video_home"), #imageLiteral(resourceName: "btn_note_home"), #imageLiteral(resourceName: "btn_gamelive_home"),#imageLiteral(resourceName: "btn_live_home")]
            popBtn.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
            popBtn.setImage(#imageLiteral(resourceName: "btn_livevideo_start_home"), for: .normal)
            UIApplication.shared.keyWindow?.addSubview(popBtn)
        }
        super.viewWillAppear(animated)
    }
    
    //添加按钮图片，修改image和title的位置
    private func layoutButton() {
        messageButton.set(image: #imageLiteral(resourceName: "siteMessageUser"), title: "消息", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        taskButton.set(image: #imageLiteral(resourceName: "image_my_task"), title: "我的任务", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        guizuButton.set(image: #imageLiteral(resourceName: "image_my_noble"), title: "斗鱼贵族", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        withdrawButton.set(image: #imageLiteral(resourceName: "Image_my_pay"), title: "鱼翅充值", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            tableView.bounces = false
        } else {
            tableView.bounces = true
        }
    }
}


