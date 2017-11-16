//
//  XEL_Container.m
//  XEL_Container
//
//  Created by Tronsis－mac on 17/5/9.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XEL_Container.h"
#import "XEL_ContainerTitleView.h"
#import "XEL_ContainerContentView.h"
#import "Xel_Bridge.h"

@interface XEL_Container ()
@property (nonatomic, strong) NSArray <NSString *> *titlesArray;
@property (nonatomic, strong) NSArray <UIViewController *> *controllersArray;
@property (nonatomic, strong) UIViewController *parentController;

@property (nonatomic, strong) XEL_ContainerTitleView *titleView;
@property (nonatomic, strong) XEL_ContainerContentView *contentView;

@property (nonatomic, strong) XEL_Configuration *configuration;
@property (nonatomic, strong) Xel_Bridge *bridge;

// =====使用协议的方式
@property (nonatomic, assign) NSInteger count;
// =====end

@end

@implementation XEL_Container

- (instancetype)initWithFrame:(CGRect)frame parentController:(UIViewController *)parentController configuration:(XEL_Configuration *)configuration {
    self = [super initWithFrame:frame];
    if (self) {
        _titlesArray = configuration.titlesArray;
        _controllersArray = configuration.controllersArray;
        _parentController = parentController;
        [parentController setAutomaticallyAdjustsScrollViewInsets:NO];
        if (configuration == nil) {
            _configuration = [[XEL_Configuration alloc] init];
        } else {
            _configuration = configuration;
        }
        
        [self addSubview:self.titleView];
        [self addSubview:self.contentView];
        
        _bridge = [[Xel_Bridge alloc] initWithTitleView:self.titleView contentView:self.contentView];
        [_bridge connect];
    }
    return self;
}

//#pragma mark -
//#pragma mark Setter
//- (void)setDataSource:(id<XEL_ContainerDataSource>)dataSource {
//    _dataSource = dataSource;
//    if (dataSource) {
//        self.count = [dataSource numberOfItemsInContainer:self];
//        for (int i = 0; i < self.count; i++) {
//            NSString *title = [dataSource container:self titleForRowAtIndex:i];
//            NSAssert(title, @"title为空");
//
//        }
//    }
//}


#pragma mark -
#pragma mark lazy init

- (XEL_ContainerTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[XEL_ContainerTitleView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _configuration.titleViewHeight)];
        _titleView.configuration = _configuration;
    }
    return _titleView;
}

- (XEL_ContainerContentView *)contentView {
    if (!_contentView) {
        _contentView = [[XEL_ContainerContentView alloc] initWithFrame:CGRectMake(0, _configuration.titleViewHeight, self.frame.size.width, self.frame.size.height - _configuration.titleViewHeight) parentController:self.parentController];
        _contentView.configuration = _configuration;
    }
    return _contentView;
}

@end
