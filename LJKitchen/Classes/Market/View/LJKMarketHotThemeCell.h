//
//  LJKMarketHotThemeCell.h
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  市集 - 热门主题 (V)

#import <UIKit/UIKit.h>

@interface LJKMarketHotThemeCell : UITableViewCell

/** CollectionViewCellClickedBlock */
@property (nonatomic, copy) void (^collectionViewCellClickedBlock)(NSInteger index);

@end
