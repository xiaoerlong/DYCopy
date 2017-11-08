//
//  XEL_ContainerTitleView.h
//  XEL_Container
//
//  Created by Tronsis－mac on 17/5/9.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

/*
    顶部滚动视图：
    1.初始化时判断是否可以滚动
        不能：固定每个item的宽度一致
        能：计算item的宽度，并将item的宽度缓存起来
    2.添加scrollView
    3.向scrollView中添加item，并配置item的状态
    4.添加sliderView
    5.点击item时的代理
 */

#import <UIKit/UIKit.h>
#import "XEL_Container.h"
#import "XEL_Configuration.h"

@class XEL_ContainerTitleView;

@protocol XEL_ContainerTitleViewDelegate <NSObject>

- (void)titleView:(XEL_ContainerTitleView *)titleView didSelectedTitleAtIndex:(NSInteger)currentIndex;

@end


@interface XEL_ContainerTitleView : UIView

@property (nonatomic, weak) id <XEL_ContainerTitleViewDelegate> delegate;
@property (nonatomic, strong) XEL_Configuration *configuration;

/// 默认初始化方法
- (instancetype)initWithFrame:(CGRect)frame;

/**
 滚动时设置label的颜色
 */
- (void)setScale:(CGFloat)scale atIndex:(NSInteger)index toNextIndex:(NSInteger)nextIndex;

//结束滚动的时候设置index
- (void)contentViewEndScrollAtIndex:(NSInteger)index;

@end
