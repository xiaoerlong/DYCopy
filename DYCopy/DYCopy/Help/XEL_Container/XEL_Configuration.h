//
//  XEL_Configuration.h
//  DYCopy
//
//  Created by xiaoerlong on 2017/7/2.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface XEL_Configuration : NSObject

#pragma mark -
#pragma mark 必须设置的属性
/// title数组
@property (nonatomic, strong) NSArray <NSString *>* titlesArray;
/// controller数组
@property (nonatomic, strong) NSArray <UIViewController *> *controllersArray;

#pragma mark -
#pragma mark item相关
/// item间距
@property (nonatomic, assign) CGFloat itemPadding;
/// 正常颜色
@property (nonatomic, strong) UIColor *normalTitleColor;
/// 正常字体大小
@property (nonatomic, assign) CGFloat normalFontSize;
/// 选中颜色
@property (nonatomic, strong) UIColor *selectedTitleColor;
/// 选中字体大小
@property (nonatomic, assign) CGFloat selectedFontSize;
/// 选中的item下标 默认为0
@property (nonatomic, assign) NSInteger defaultIndex;

#pragma mark -
#pragma mark sliderView相关
/// 是否显示sliderView 默认为YES
@property (nonatomic, assign) BOOL showSliderView;
/// sliderView的颜色 默认为 [UIColor colorWithRed:235 / 255.0 green:137 / 255.0 blue:36 / 255.0 alpha:1]
@property (nonatomic, strong) UIColor *sliderViewColor;
/// sliderView的高度 默认为3
@property (nonatomic, assign) CGFloat sliderViewHeight;
/// slide是否有圆角 默认为YES
@property (nonatomic, assign) BOOL sliderHasRadius;
/// slider是否跟随移动 默认为YES
@property (nonatomic, assign) BOOL sliderMoveAlongWithScroll;
/// 宽度是否固定 默认为NO
@property (nonatomic, assign) BOOL sliderFixWidth;
/// slider宽度相对于对应titleLabel的间距 默认为0
@property (nonatomic, assign) CGFloat sliderPadding;

#pragma mark -
#pragma mark titleView相关
/// titleView高度 默认为50
@property (nonatomic, assign) CGFloat titleViewHeight;
/// titleView是否可以滚动 默认为NO
@property (nonatomic, assign) BOOL titleViewScrollEable;

@end
