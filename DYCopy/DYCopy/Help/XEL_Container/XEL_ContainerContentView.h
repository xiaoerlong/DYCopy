//
//  XEL_ContainerContentView.h
//  XEL_Container
//
//  Created by Tronsis－mac on 17/5/9.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XEL_Configuration.h"

@protocol XEL_ContainerContentViewDelegate <NSObject>

// 偏移量
- (void)contentViewDidScrollAtCurrentIndex:(NSInteger)currentIndex toNextIndex:(NSInteger)nextIndex progress:(CGFloat)progress;
- (void)contentViewEndScrollAtCurrentIndex:(NSInteger)currentIndex;

@end

@interface XEL_ContainerContentView : UIView

@property (nonatomic, weak) id <XEL_ContainerContentViewDelegate> delegate;
@property (nonatomic, strong) XEL_Configuration *configuration;
// 获取controller
@property (nonatomic, strong, readonly) UIViewController *controller;

/// 初始化 多个controller
- (instancetype)initWithFrame:(CGRect)frame parentController:(UIViewController *)parentController;


// 当点击顶部按钮的时候，切换contentView
- (void)contentViewEndScrollAtIndex:(NSInteger)currentIndex;


@end
