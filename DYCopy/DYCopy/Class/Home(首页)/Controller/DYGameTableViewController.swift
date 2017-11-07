//
//  DYGameTableViewController.swift
//  DYCopy
//
//  Created by Tronsis－mac on 17/5/8.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYGameTableViewController: DYHomeCategoryViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titlesArray = [["英雄联盟", "炉石传说", "DOTA2", "穿越火线",
                        "魔兽世界", "兽王先锋", "主机游戏", "跳伞求生",],
                       ["绝地求生", "格斗游戏", "DNF", "棋牌娱乐",
                        "CS:GO", "魔兽争霸", "怀旧游戏", "更多分类",],
        ]
    }
}

