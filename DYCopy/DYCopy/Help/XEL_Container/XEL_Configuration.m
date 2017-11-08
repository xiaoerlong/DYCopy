//
//  XEL_Configuration.m
//  DYCopy
//
//  Created by xiaoerlong on 2017/7/2.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

#import "XEL_Configuration.h"

@implementation XEL_Configuration

- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultConfiguration];
    }
    return self;
}


- (void)defaultConfiguration {
    self.titleViewHeight = 50;
    self.itemPadding = 10;
    self.sliderViewHeight = 3;
    self.sliderPadding = 0;
    self.defaultIndex = 0;
    
    self.normalTitleColor = [UIColor blackColor];
    self.normalFontSize = 15;
    
    self.selectedTitleColor = [UIColor colorWithRed:235 / 255.0 green:137 / 255.0 blue:36 / 255.0 alpha:1];
    self.selectedFontSize = 15;
    
    self.sliderViewColor = [UIColor colorWithRed:235 / 255.0 green:137 / 255.0 blue:36 / 255.0 alpha:1];
    
    self.showSliderView = YES;
    self.sliderMoveAlongWithScroll = YES;
    self.sliderHasRadius = YES;
    self.sliderFixWidth = NO;
    
    self.titleViewScrollEable = NO;
}

#pragma mark - Setter

@end
