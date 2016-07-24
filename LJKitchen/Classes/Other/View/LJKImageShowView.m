//
//  LJKImageShowView.m
//  LJKitchen
//
//  Created by  a on 16/7/1.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKImageShowView.h"

#import "LJKPicture.h"
#import "LJKReviewPhoto.h"

#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface LJKImageShowView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
/** 轮播器 - 页面显示 */
@property (nonatomic, strong) UILabel *pageDisplay;
@end

@implementation LJKImageShowView

static NSString *const imageCellIdentifier = @"imageCell";

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 350);
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350) collectionViewLayout:flowLayout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:imageCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (UILabel *)pageDisplay {
    if (!_pageDisplay) {
        _pageDisplay = [UILabel labelWithTextColor:Color_DarkGray
                                   backgroundColor:Color_TintWhite
                                          fontSize:13
                                             lines:1
                                     textAlignment:NSTextAlignmentCenter];
        _pageDisplay.layer.cornerRadius = 15;
        _pageDisplay.clipsToBounds = YES;
    }
    return _pageDisplay;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self addSubview:self.pageDisplay];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_pageDisplay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.right.equalTo(self.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.bottom.equalTo(self.mas_bottom).offset(-LJKAuthorIcon2CellLeft);
        }];
    }
    return self;
}

// 快速创建 & block
+ (instancetype)imageShowViewWithShowImageBlock:(ShowImageBlock)block {
    LJKImageShowView *showView = [[ LJKImageShowView alloc] init];
    showView.showImageBlock = block;
    return showView;
}

#pragma mark - UICollectionView 数据源 & 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.imageArray.count) {
        return self.imageArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCellIdentifier
                                                                           forIndexPath:indexPath];
    
    NSInteger tag = 20;
    UIImageView *imageV = [cell.contentView viewWithTag:tag];
    if (!imageV) {
        imageV = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageV.tag = tag;
        [cell.contentView addSubview:imageV];
    }
    
    if (self.imageArray.count) {
        // 展示类型为菜谱
        if (self.type == LJKShowViewTypeDish) {
            LJKPicture *picData = self.imageArray[indexPath.item];
            NSURL *imageUrl = [NSURL URLWithString:picData.bigPhoto];
            [imageV sd_setImageWithURL:imageUrl];
        }
        // 展示类型为 评价(买买买) 、商品总览、 商品详情
        else if (self.type == LJKShowViewTypeReview || self.type == LJKShowViewTypeGoods || self.type == LJKShowViewTypeDetail) {
            
            LJKReviewPhoto *photo = self.imageArray[indexPath.row];
            [imageV sd_setImageWithURL:[NSURL URLWithString:photo.url]];
            
        } else { // 应该不会有这种情况……
            imageV.image = [UIImage imageNamed:@"defaultUserHeader"];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 传递下标 图片相对window的frame 到控制器
    CGRect currentRect = [self convertRect:self.bounds toView:nil];
    !self.showImageBlock ? : self.showImageBlock(indexPath.item, currentRect);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 跟pageControl 计算方式一样 
    NSInteger index = (scrollView.contentOffset.x + self.collectionView.width * 0.5) / self.collectionView.width;
    self.pageDisplay.text = [NSString stringWithFormat:@"%zd/%zd", index + 1, self.imageArray.count];
}

// scrollView停止滚动后记录contentOffset.x
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    !self.imageViewDidScrolledBlock ? : self.imageViewDidScrolledBlock(scrollView.contentOffset.x);
}


#pragma mark - 传入模型 
// 根据图片数量 -> 显示/隐藏pageDisplay
- (void)setImageArray:(NSArray *)imageArray {
    
    _imageArray = imageArray;
    if (imageArray.count <= 1) {
        self.pageDisplay.hidden = YES;
    } else {
        self.pageDisplay.hidden = NO;
        NSString *display = [NSString stringWithFormat:@"1/%zd",imageArray.count];
        self.pageDisplay.text = display;
    }
}

// 计算滚动动作对pageDisplay的影响
- (void)setImageViewCurrentLocation:(CGFloat)imageViewCurrentLocation {
    
    _imageViewCurrentLocation = imageViewCurrentLocation;
    // 恢复 collectionView滚动的位置
    [self.collectionView setContentOffset:CGPointMake(imageViewCurrentLocation, 0)];
    // 恢复 页数显示 (记得+1！....)
    if (!self.pageDisplay.hidden && self.imageArray.count) {
        NSInteger currentIndex = imageViewCurrentLocation / self.collectionView.width + 1;
        self.pageDisplay.text = [NSString stringWithFormat:@"%zd/%zd", currentIndex, self.imageArray.count];
    }
}

// 计算当前索引
- (void)setCurrentIndex:(NSUInteger)currentIndex {
    
    _currentIndex = currentIndex;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:NO];
    if (!self.pageDisplay.hidden && self.imageArray.count) {
        self.pageDisplay.text = [NSString stringWithFormat:@"%zd/%zd", currentIndex + 1, self.imageArray.count];
    }
}

- (void)setType:(LJKShowViewType)type {
    _type = type;
    if (type == LJKShowViewTypeDetail) {
        self.collectionView.backgroundColor = [UIColor clearColor];
    }
}

@end
