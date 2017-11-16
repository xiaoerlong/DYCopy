//
//  XEL_Container.h
//  XEL_Container
//
//  Created by Tronsis－mac on 17/5/9.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XEL_Configuration.h"

//@class XEL_Container;
//// 数据源协议
//@protocol XEL_ContainerDataSource
///**
//    container的内容数量
// */
//- (NSInteger)numberOfItemsInContainer:(XEL_Container *)container;
//
///**
//    每个子视图的title
// */
//- (NSString *)container:(XEL_Container *)container titleForRowAtIndex:(NSInteger)index;
//
///**
//    每个子视图的controller
// */
//- (UIViewController *)container:(XEL_Container *)container controllerForRowAtIndex:(NSInteger)index;
//
//@end
//
//@protocol XEL_ContainerDelegate
//
//// titleView相关
//- (CGFloat)titleViewHeightInContainer:(XEL_Container *)container;
//
//- (CGFloat)itemPaddingInContiner:(XEL_Container *)container;
//
//@end


@interface XEL_Container : UIView

//@property (nonatomic, weak) id <XEL_ContainerDataSource> dataSource;
//@property (nonatomic, weak) id <XEL_ContainerDelegate> delegate;
//
//- (void)viewControllerAtIndex:(NSInteger)index;

- (instancetype)initWithFrame:(CGRect)frame parentController:(UIViewController *)parentController configuration:(XEL_Configuration *)configuration;

@end
