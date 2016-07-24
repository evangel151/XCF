//
//  LJKSettingCell.h
//  LJKitchen
//
//  Created by  a on 16/6/26.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJKAuthorDetail;
@interface LJKSettingCell : UITableViewCell

@property (nonatomic, strong) LJKAuthorDetail *authorDetail;

@property (nonatomic, strong) UIImageView *detailArrow;

@end
