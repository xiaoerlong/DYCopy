//
//  DYBaseNavigationController.swift
//  DYCopy
//
//  Created by Tronsis－mac on 17/7/13.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

class DYBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .done, target: nil, action: nil)
        /*
         A->B
         A:rootViewController
         B:viewController
         系统在push B的时候，B控制器其实已经加入到导航控制器的子控制器中了；
         此时，B才是最顶部的控制器，B的hidesBottomBarWhenPushed属性才是正确控制tabbar隐藏的关键，而不是A的；
         */
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
