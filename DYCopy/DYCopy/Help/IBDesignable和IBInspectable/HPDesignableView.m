//
//  HPDesignableView.m
//  Huaptec
//
//  Created by Tronsis－mac on 17/8/15.
//  Copyright © 2017年 tronsis. All rights reserved.
//

#import "HPDesignableView.h"

@implementation HPDesignableView
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}
- (void)setBorderCorlor:(UIColor *)borderCorlor {
    self.layer.borderColor = borderCorlor.CGColor;
}
@end
