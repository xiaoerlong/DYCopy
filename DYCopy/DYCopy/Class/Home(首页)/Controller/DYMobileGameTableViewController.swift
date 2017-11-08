//
//  DYMobileGameTableViewController.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/5/2.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYMobileGameTableViewController: DYHomeCategoryViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titlesArray = [["王者荣耀", "天天狼人杀", "新游中心", "魂斗罗归来",
                        "火影忍者", "阴阳师", "二次元手游", "球球大作战",],
                       ["战地指挥官", "狼人杀世界", "皇室战争", "梦幻西游手游",
                        "光明大陆", "决斗之城", "龙之谷手游", "更多分类",],
        ]
    }
}

