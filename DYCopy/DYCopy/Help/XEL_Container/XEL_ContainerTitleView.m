//
//  XEL_ContainerTitleView.m
//  XEL_Container
//
//  Created by Tronsis－mac on 17/5/9.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XEL_ContainerTitleView.h"


@interface XEL_ContainerTitleView ()
//标题视图
@property (nonatomic, strong) UIScrollView *titlesScrollView;
@property (nonatomic, strong) NSArray <NSString *> *titlesArray;
//title宽度缓存
@property (nonatomic, strong) NSMutableArray <NSNumber *> *titleWidthsArray;
@property (nonatomic, strong) NSMutableArray <UILabel *> *labelsArray;

@property (nonatomic, strong) UIView *sliderView;
//记录titleView的历史偏移量
@property (nonatomic, assign) CGFloat currentOffsetX;

@end

@implementation XEL_ContainerTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleWidthsArray = [NSMutableArray array];
        self.labelsArray = [NSMutableArray array];
        _currentOffsetX = 0;
    }
    return self;
}

#pragma mark -
#pragma mark pirvate

// 添加子视图
- (void)addContentView {
    // 1.添加scrollView
    [self addSubview:self.titlesScrollView];
    // 2.添加scrollView的contentView，即item
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = 0;
    CGFloat labelH = CGRectGetHeight(self.titlesScrollView.frame);
    for (int i = 0; i < _titlesArray.count; i++) {
        labelW = self.titleWidthsArray[i].floatValue;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
//        label.layer.borderColor = [UIColor redColor].CGColor;
//        label.layer.borderWidth = 1.0;
        labelX += labelW;
        label.tag = i;
        label.text = _titlesArray[i];
        label.font = [UIFont systemFontOfSize:_configuration.normalFontSize];
        label.textAlignment = NSTextAlignmentCenter;
        [_titlesScrollView addSubview:label];
        [_labelsArray addObject:label];
        
        // 添加点击事件
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapLabelGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)];
        [label addGestureRecognizer:tapLabelGes];
        
        if (self.configuration.defaultIndex == i) {
            label.textColor = _configuration.selectedTitleColor;
        } else {
            label.textColor = _configuration.normalTitleColor;
        }
    }
    if (self.configuration.titleViewScrollEable) {
        _titlesScrollView.contentSize = CGSizeMake(labelX, 0);
    } else {
        _titlesScrollView.contentSize = CGSizeMake(self.frame.size.width, 0);
    }
    // 设置slider正确的偏移量
    [self scrollToCenterWithView:self.labelsArray[self.configuration.defaultIndex] progress:1];
    if (self.configuration.showSliderView) {
        // 3.添加sliderView
        [self addSubview:self.sliderView];
    }
}

// 获取每个title的宽度
- (void)getTitleWidth {
    if (self.configuration.titleViewScrollEable) {
        for (NSString *title in self.titlesArray) {
            CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_configuration.normalFontSize]}];
            [self.titleWidthsArray addObject:@(size.width + 2 * self.configuration.itemPadding)];
        }
    } else {
        for (int i = 0; i < self.titlesArray.count; i++) {
            CGFloat width = self.frame.size.width / self.titlesArray.count;
            [self.titleWidthsArray addObject:@(width)];
        }
    }
}

// 修改sliderView的frame
- (void)adjustSliderViewFrameFromCurrentIndex:(NSInteger)currentIndex toNextIndex:(NSInteger)nextIndex progress:(CGFloat)progress {
    UILabel *currentLabel = _labelsArray[currentIndex];
    UILabel *nextLabel = _labelsArray[nextIndex];
    
    // 开始位置
    CGRect startFrame = currentLabel.frame;
    // 结束位置
    CGRect endFrame = nextLabel.frame;
    
    // sliderView的frame
    CGRect sliderFrame = self.sliderView.frame;
    
    CGFloat sliderX = 0;
    CGFloat sliderWidth = 0;
    if (self.configuration.sliderFixWidth == NO && self.configuration.titleViewScrollEable) { // slider宽度不固定 && titleView可以滚动
        sliderWidth = (endFrame.size.width - startFrame.size.width) * progress + startFrame.size.width - 2 * self.configuration.sliderPadding;
    } else if (self.configuration.sliderFixWidth == YES && self.configuration.titleViewScrollEable) { // slider宽度固定 && titleView可以滚动
        sliderWidth = sliderFrame.size.width;
    } else if (self.configuration.sliderFixWidth == NO && self.configuration.titleViewScrollEable) { // slider宽度不固定 && titleView不可以滚动
        sliderWidth = (endFrame.size.width - startFrame.size.width) * progress + startFrame.size.width - 2 * self.configuration.sliderPadding;
    } else { // slider宽度固定 && titleView不可以滚动
        sliderWidth = sliderFrame.size.width;
    }
    
    sliderX = (CGRectGetMinX(endFrame) - CGRectGetMinX(startFrame)) * progress + CGRectGetMinX(startFrame) - self.titlesScrollView.contentOffset.x;
    
    sliderFrame.origin.x = sliderX + self.configuration.sliderPadding;
    sliderFrame.size.width = sliderWidth;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.sliderView.frame = sliderFrame;
    } completion:^(BOOL finished) {
        
    }];
}

// 将title居中
- (void)scrollToCenterWithView:(UIView *)view progress:(CGFloat)progress {
    if (self.configuration.titleViewScrollEable == NO) {
        return;
    }
    CGFloat offsetX = view.center.x - self.titlesScrollView.frame.size.width * 0.5;
    //最小偏移量
    if (offsetX < 0) {
        offsetX = 0;
    }
    //最大偏移量
    CGFloat maxOffsetX = self.titlesScrollView.contentSize.width - self.titlesScrollView.frame.size.width;
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.titlesScrollView setContentOffset:CGPointMake((offsetX - _currentOffsetX) * progress + _currentOffsetX, 0) animated:NO];
}

// 颜色值
- (NSArray *)getRGBWithColor:(UIColor *)color
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}

#pragma mark -
#pragma mark tapLabel

- (void)tapLabel:(UITapGestureRecognizer *)tap {
    UILabel *currentLabel = (UILabel *)tap.view;
    [self setScale:1 atIndex:self.configuration.defaultIndex toNextIndex:currentLabel.tag];
    self.configuration.defaultIndex = currentLabel.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(titleView:didSelectedTitleAtIndex:)]) {
        [_delegate titleView:self didSelectedTitleAtIndex:self.configuration.defaultIndex];
    }
}

#pragma mark -
#pragma mark Public

- (void)setScale:(CGFloat)scale atIndex:(NSInteger)index toNextIndex:(NSInteger)nextIndex {
    NSArray *normalColors = [self getRGBWithColor:_configuration.normalTitleColor];
    NSArray *selectedColors = [self getRGBWithColor:_configuration.selectedTitleColor];
    CGFloat red     = [selectedColors[0] floatValue] - [normalColors[0] floatValue];
    CGFloat green   = [selectedColors[1] floatValue] - [normalColors[1] floatValue];
    CGFloat blue    = [selectedColors[2] floatValue] - [normalColors[2] floatValue];
    
    //1. 获取label
    UILabel *currentlabel = _labelsArray[index];
    UILabel *nextLabel = _labelsArray[nextIndex];
    //2. 设置颜色
    currentlabel.textColor = [UIColor colorWithRed:(1 - scale) * red + [normalColors[0] floatValue] green:(1 - scale) * green + [normalColors[1] floatValue] blue:(1 - scale) * blue + [normalColors[2] floatValue] alpha:1];
    nextLabel.textColor = [UIColor colorWithRed:scale * red + [normalColors[0] floatValue] green:scale * green + [normalColors[1] floatValue] blue:scale * blue + [normalColors[2] floatValue] alpha:1];
    
    // 3.将title居中
    [self scrollToCenterWithView:nextLabel progress:scale];
    // 4.调整sliderView
    [self adjustSliderViewFrameFromCurrentIndex:index toNextIndex:nextIndex progress:scale];
    
    // 5.修改currentIndex
    self.configuration.defaultIndex = nextIndex;
}

- (void)contentViewEndScrollAtIndex:(NSInteger)index {
    self.configuration.defaultIndex = index;
    _currentOffsetX = self.titlesScrollView.contentOffset.x;

}

#pragma mark -
#pragma mark setter

- (void)setConfiguration:(XEL_Configuration *)configuration {
    _configuration = configuration;
    self.titlesArray = configuration.titlesArray.copy;
    [self getTitleWidth];
    [self addContentView];
}

#pragma mark -
#pragma mark lazy init

- (UIScrollView *)titlesScrollView {
    if (!_titlesScrollView) {
        _titlesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titlesScrollView.scrollEnabled = self.configuration.titleViewScrollEable;
        _titlesScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _titlesScrollView;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
        _sliderView.backgroundColor = _configuration.sliderViewColor;
        CGFloat originX = self.configuration.sliderPadding + CGRectGetMinX(self.labelsArray[self.configuration.defaultIndex].frame);
        CGFloat originY = self.frame.size.height - self.configuration.sliderViewHeight;
        CGFloat width = self.titleWidthsArray.firstObject.floatValue - 2 * self.configuration.sliderPadding;
        CGFloat height = _configuration.sliderViewHeight;
        _sliderView.frame = CGRectMake(originX, originY, width, height);
        if (self.configuration.sliderHasRadius) {
            _sliderView.layer.cornerRadius = _configuration.sliderViewHeight / 2;
        }
    }
    return _sliderView;
}

@end
