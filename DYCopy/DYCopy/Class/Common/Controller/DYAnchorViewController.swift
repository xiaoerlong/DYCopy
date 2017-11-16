//
//  DYAnchorViewController.swift
//  DYCopy
//
//  Created by Tronsis－mac on 2017/11/16.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYAnchorViewController: UIViewController {

    fileprivate var textField = UITextField.init()
    fileprivate var btn = UIButton.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildView()
        
        
    }
}

extension DYAnchorViewController {
    // 添加子视图
    fileprivate func setupChildView() {
        self.view.backgroundColor = UIColor.white
        textField = UITextField.init(frame: CGRect.init(x: 20, y: 20, width: 200, height: 40))
        textField.placeholder = "请输入IP地址"
        self.view.addSubview(textField)
        btn = UIButton.init(frame: CGRect.init(x: self.view.frame.size.width - 20 - 100, y: 20, width: 100, height: 40))
        btn.setTitle("确定", for: .normal)
        btn.backgroundColor = UIColor.green
        btn.addTarget(self, action: #selector(tapDoneAction), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc fileprivate func tapDoneAction(_ sender: UIButton) {
        textField.resignFirstResponder()
        if let text = textField.text {
            let url = "rtmp://" + text + ":1935/live1/room"
            let preview = LCLivePreview.init(frame: CGRect.init(x: 0, y: 60, width: self.view.frame.size.width, height: self.view.frame.size.height - 60))
            preview.url = url
            self.view.addSubview(preview)
        }
    }
}
