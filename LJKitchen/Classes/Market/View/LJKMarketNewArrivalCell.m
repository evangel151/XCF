//
//  LJKMarketNewArrivalCell.m
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKMarketNewArrivalCell.h"
#import "LJKMarketArrivalItem.h"

#import <Masonry.h>

@interface LJKMarketNewArrivalCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 市集 - 新品上架 - 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 市集 - 新品上架 - collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LJKMarketNewArrivalCell

static NSString *const newArrivalIdentifier = @"newArrivalCell";

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = Color_BackGround;
        
        _titleLabel = [UILabel labelWithTextColor:Color_TintBlack
                                  backgroundColor:Color_Clear
                                         fontSize:15 lines:1
                                    textAlignment:NSTextAlignmentLeft];
        _titleLabel.text = @"最新上架";
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top);
            make.height.equalTo(@(30));
        }];
        
        CGFloat itemWH = (SCREEN_WIDTH - 20 * 3) / 2;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(itemWH, itemWH + 87);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = Color_Clear;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[LJKMarketArrivalItem class] forCellWithReuseIdentifier:newArrivalIdentifier];
        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.height.equalTo(@(1350));
        }];
    }
    return self;
}

#pragma mark - CollectionView 数据源 & 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LJKMarketArrivalItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:newArrivalIdentifier forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    
    return cell;
}

#pragma mark - 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.collectionViewCellClickedBlock ? : self.collectionViewCellClickedBlock(indexPath.row);
}

@end
