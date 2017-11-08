//
//  Xel_Bridge.h
//  DYCopy
//
//  Created by xiaoerlong on 2017/7/2.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

/*
    作为titleView和contentView的连接桥梁，管理两者的点击事件
 */

#import <Foundation/Foundation.h>
#import "XEL_ContainerTitleView.h"
#import "XEL_ContainerContentView.h"

@interface Xel_Bridge : NSObject

- (instancetype)initWithTitleView:(XEL_ContainerTitleView *)titleView
                      contentView:(XEL_ContainerContentView *)contentView;

/// 开始连接
- (void)connect;

@end
