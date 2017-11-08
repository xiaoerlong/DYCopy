//
//  Xel_Bridge.m
//  DYCopy
//
//  Created by xiaoerlong on 2017/7/2.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

#import "Xel_Bridge.h"

@interface Xel_Bridge () <XEL_ContainerTitleViewDelegate, XEL_ContainerContentViewDelegate>
@property (nonatomic, strong) XEL_ContainerTitleView *titleView;
@property (nonatomic, strong) XEL_ContainerContentView *contentView;
@end

@implementation Xel_Bridge

- (instancetype)initWithTitleView:(XEL_ContainerTitleView *)titleView contentView:(XEL_ContainerContentView *)contentView {
    if (self) {
        self.titleView = titleView;
        self.contentView = contentView;
    }
    return self;
}

- (void)connect {
    self.titleView.delegate = self;
    self.contentView.delegate = self;
}

#pragma XEL_ContainerTitleViewDelegate
- (void)titleView:(XEL_ContainerTitleView *)titleView didSelectedTitleAtIndex:(NSInteger)currentIndex {
    [_contentView contentViewEndScrollAtIndex:currentIndex];
}

#pragma XEL_ContainerContentViewDelegate
- (void)contentViewDidScrollAtCurrentIndex:(NSInteger)currentIndex toNextIndex:(NSInteger)nextIndex progress:(CGFloat)progress {
    [_titleView setScale:progress atIndex:currentIndex toNextIndex:nextIndex];
}

- (void)contentViewEndScrollAtCurrentIndex:(NSInteger)currentIndex {
    [_titleView contentViewEndScrollAtIndex:currentIndex];
}

@end
