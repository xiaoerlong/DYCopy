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

    @IBOutlet weak var playView: BMPlayer!
    @IBOutlet weak var birefView: UIView!
    
    var jumpURLString: String?
    var room_id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        DYBaseNetworkTool.getRoomDetial(room_id: room_id ?? "") { (data) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(jumpURLString as Any)
        if let jumpURLString = jumpURLString, jumpURLString != "" {
            playView.playWithURL(URL(string: jumpURLString)!)
        }
        
        playView.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true { return }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        let configuration = XEL_Configuration.init()
        configuration.controllersArray = [UIViewController.init()]
        configuration.titlesArray = ["1", "2", "3"]
        
        let container = XEL_Container.init(frame: birefView.bounds, parentController: self, configuration: configuration)
        birefView.addSubview(container!)
    }
}
