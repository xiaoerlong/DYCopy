//
//  XEL_ContainerContentView.m
//  XEL_Container
//
//  Created by Tronsis－mac on 17/5/9.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XEL_ContainerContentView.h"

@interface XEL_ContainerContentView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray <UIViewController *> *controllersArray;
@property (nonatomic, strong) UIViewController *parentController;
@property (nonatomic, strong) UICollectionView *collectionView;
//记录历史偏移量
@property (nonatomic, assign) CGPoint currentOffset;
@end

static NSString *kContentCellID = @"contentCell";

@implementation XEL_ContainerContentView

- (instancetype)initWithFrame:(CGRect)frame parentController:(UIViewController *)parentController {
    self = [super initWithFrame:frame];
    if (self) {
        self.parentController = parentController;
    }
    return self;
}

- (void)setConfiguration:(XEL_Configuration *)configuration {
    _configuration = configuration;
    [self setupUI];
}

#pragma mark -
#pragma mark private

- (void)setupUI {
    // 先判断跟title的数量是否一致，如果少于title的数量，则在后面添加最后一个controller
    NSMutableArray *tempArray = [NSMutableArray array];
    if (self.configuration.controllersArray.count < self.configuration.titlesArray.count) {
        for (int i = 0; i < self.configuration.titlesArray.count; i++) {
            if (i < self.configuration.controllersArray.count) {
                [tempArray addObject:self.configuration.controllersArray[i]];
            } else {
                
                UIViewController *myObj = (UIViewController *)[[NSClassFromString(NSStringFromClass([self.configuration.controllersArray.lastObject class])) alloc] init];
                [tempArray addObject:myObj];
            }
        }
    } else {
        for (int i = 0; i < self.configuration.titlesArray.count; i++) {
            [tempArray addObject:self.configuration.controllersArray[i]];
        }
    }
    _controllersArray = tempArray.copy;
    // 1.添加所有控制器
    for (UIViewController *child in _controllersArray) {
        [_parentController addChildViewController:child];
    }
    
    // 2.添加collectionview
    [self addSubview:self.collectionView];
    // 设置scrollview正确的偏移量
    [self.collectionView setContentOffset:CGPointMake(self.frame.size.width * self.configuration.defaultIndex, 0)];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.controllersArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    
    // 移除之前的
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    // 取出控制器
    UIViewController *childVC = self.controllersArray[indexPath.row];
    childVC.view.frame = cell.bounds;
    [cell.contentView addSubview:childVC.view];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.configuration.sliderMoveAlongWithScroll == NO) {
        return;
    }
    //scrollView的整体滑动比例
    CGFloat ratio = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (_currentOffset.x < scrollView.contentOffset.x) {
        // 向右滑动
        //当前显示视图的下标(如果向右移动的话就是已经显示的view，否则是即将显示的view)
        NSInteger index = ratio / 1.0001;
        //当前页面的滑动比例
        CGFloat progress = ratio - index;
        if (_delegate && [_delegate respondsToSelector:@selector(contentViewDidScrollAtCurrentIndex:toNextIndex:progress:)]) {
            [_delegate contentViewDidScrollAtCurrentIndex:index toNextIndex:index + 1 progress:progress];
        }
    } else {
        // 向左滑动
        //当前显示视图的下标(如果向右移动的话就是已经显示的view，否则是即将显示的view)
        NSInteger index = ratio / 0.9999;
        //当前页面的滑动比例
        CGFloat progress = ratio - index;
        if (_delegate && [_delegate respondsToSelector:@selector(contentViewDidScrollAtCurrentIndex:toNextIndex:progress:)]) {
            [_delegate contentViewDidScrollAtCurrentIndex:index + 1 toNextIndex:index progress:1 - progress];
        }
    }
    _currentOffset = scrollView.contentOffset;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (_delegate && [_delegate respondsToSelector:@selector(contentViewEndScrollAtCurrentIndex:)]) {
        [_delegate contentViewEndScrollAtCurrentIndex:index];
    }
    _currentOffset = scrollView.contentOffset;
}

#pragma mark -
#pragma mark Public
//点击顶部label的时候滚动
- (void)contentViewEndScrollAtIndex:(NSInteger)currentIndex {
    //如果animated=YES的话，切换的时候，会显示中间的视图
    [self.collectionView setContentOffset:CGPointMake(currentIndex * self.collectionView.frame.size.width, 0) animated:NO];
}

#pragma mark -
#pragma mark lazy init

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        // 1.创建布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = self.bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // 2.创建collectionview
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
    }
    return _collectionView;
}

@end
