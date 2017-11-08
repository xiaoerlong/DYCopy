//
//  HPDesignableView.h
//  Huaptec
//
//  Created by Tronsis－mac on 17/8/15.
//  Copyright © 2017年 tronsis. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface HPDesignableView : UIView
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderCorlor;
@end
