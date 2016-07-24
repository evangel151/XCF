//
//  LJKMarketSortCell.m
//  LJKitchen
//
//  Created by  a on 16/6/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKMarketSortCell.h"

@interface LJKMarketSortCell ()

@end

@implementation LJKMarketSortCell

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = (SCREEN_WIDTH - 2) / 3;
        CGFloat height = (SCREEN_WIDTH - 2) / 3;
        _sortItemView = [[UIImageView alloc] init];
        _sortItemView.frame = CGRectMake(x, y, width, height);
        _sortItemView.contentMode = UIViewContentModeScaleAspectFit; // 填充模式
        [self.contentView addSubview:_sortItemView];
        self.sortItemView = _sortItemView;
    }
    return self;
}

#pragma mark - useless
// useless
+ (NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"MarketSortCellIdentifier";
    return cellIdentifier;
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView
                          forIndexPath:(NSIndexPath *)indexPath {
    LJKMarketSortCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:[LJKMarketSortCell cellIdentifier]
                                              forIndexPath:indexPath];
    return cell;
}
@end
