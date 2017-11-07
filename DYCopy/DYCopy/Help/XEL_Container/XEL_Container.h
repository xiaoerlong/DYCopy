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

@interface XEL_Container : UIView

- (instancetype)initWithFrame:(CGRect)frame parentController:(UIViewController *)parentController configuration:(XEL_Configuration *)configuration;

@end
