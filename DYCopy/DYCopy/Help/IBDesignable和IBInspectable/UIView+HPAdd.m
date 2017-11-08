//
//  UIView+HPAdd.m
//  Huaptec
//
//  Created by Tronsis－mac on 17/8/15.
//  Copyright © 2017年 tronsis. All rights reserved.
//

#import "UIView+HPAdd.h"

IB_DESIGNABLE
@implementation UIView (HPAdd)
- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderCorlor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderCorlor:(UIColor *)borderCorlor {
    self.layer.borderColor = borderCorlor.CGColor;
}

@end
