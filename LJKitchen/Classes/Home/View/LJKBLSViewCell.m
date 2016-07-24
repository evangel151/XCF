//
//  LJKBLSViewCell.m
//  LJKitchen
//
//  Created by  a on 16/6/21.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKBLSViewCell.h"
#import "LJKDish.h"
#import "LJKAuthor.h"
#import "LJKPicture.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface LJKBLSViewCell ()
/** 作品大图 */
@property (nonatomic, strong) UIImageView *imageView;
/** 作品作者 */
@property (nonatomic, strong) UILabel *cookerLabel;
/** 作品名 */
@property (nonatomic, strong) UILabel *dishNameLabel;
/** 点赞按钮 */
@property (nonatomic, strong) UIButton *attitudeButton;
/** 点赞数 */
@property (nonatomic, strong) UILabel *attitudeCountLabel;
@end

@implementation LJKBLSViewCell

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor whiteColor];
    }
    return _imageView;
}

- (UILabel *)cookerLabel {
    if (!_cookerLabel) {
        _cookerLabel = [UILabel labelWithTextColor:Color_DarkGray
                                   backgroundColor:[UIColor clearColor]
                                          fontSize:13
                                             lines:1
                                     textAlignment:NSTextAlignmentCenter];
    }
    return _cookerLabel;
}

- (UILabel *)dishNameLabel {
    if (!_dishNameLabel) {
        _dishNameLabel = [UILabel labelWithTextColor:[UIColor blackColor]
                                     backgroundColor:[UIColor clearColor]
                                            fontSize:15
                                               lines:0
                                       textAlignment:NSTextAlignmentCenter];
    }
    return _dishNameLabel;
}

- (UIButton *)attitudeButton {
    if (!_attitudeButton) {
        _attitudeButton = [[UIButton alloc] init];
        [_attitudeButton setImage:[UIImage imageNamed:@"likeSmall"] forState:UIControlStateNormal];
        [_attitudeButton setImage:[UIImage imageNamed:@"likedSmall"] forState:UIControlStateSelected];
        [_attitudeButton addTarget:self
                            action:@selector(attitude:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _attitudeButton;
}

- (UILabel *)attitudeCountLabel {
    if (!_attitudeCountLabel) {
        _attitudeCountLabel = [UILabel labelWithTextColor:Color_DarkGray
                                          backgroundColor:[UIColor clearColor]
                                                 fontSize:13
                                                    lines:1
                                            textAlignment:NSTextAlignmentCenter];
    }
    return _attitudeCountLabel;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.cookerLabel];
        [self.contentView addSubview:self.dishNameLabel];
        [self.contentView addSubview:self.attitudeButton];
        [self.contentView addSubview:self.attitudeCountLabel];
//        [self setupFakeData];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(self.contentView.mas_height).multipliedBy(0.6);
        }];
        
        [_cookerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
        }];
        
        [_dishNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cookerLabel.mas_bottom).offset(5);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
        }];
        
        [_attitudeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.top.equalTo(self.dishNameLabel.mas_bottom).offset(5);
            make.centerX.equalTo(self.imageView.mas_centerX);
        }];
        
        [_attitudeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.attitudeButton.mas_bottom);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - 测试数据
/** 假数据 */
- (void)setupFakeData {
    self.imageView.image = [UIImage imageNamed:@"iconLM"];
    self.cookerLabel.text = @"测试人员233";
    self.attitudeCountLabel.text = @"998";
    self.dishNameLabel.text = @"美味香蕉戚风蛋糕";
}

#pragma mark - 传入模型
/** 传入模型 */
- (void)setDish:(LJKDish *)dish {
    _dish = dish;
    
    // dish图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dish.main_pic.url]];
    
    // 用户名
    NSString *displayName;
    if (dish.author.current_location.length) {
        NSString *currentLoc = [NSString stringWithFormat:@"(%@)", [dish.author.current_location substringToIndex:2]];
        displayName = [NSString stringWithFormat:@"%@ %@", dish.author.name, currentLoc];
    } else {
        displayName = dish.author.name;
    }
    [self.cookerLabel setAttributeTextWithString:displayName range:NSMakeRange(0, dish.author.name.length)];
    // self.cookerLabel.text = displayName;
    
    // 作者描述
    if (dish.name.length) {
        self.dishNameLabel.text = dish.name;
    }
//    else if ([dish.name isEqualToString:@"晚餐•2016年6月22日"]) {
//        self.dishNameLabel.text = @"-----";
//    }
    
    // 点赞按钮的选中状态
    if (dish.digged_by_me) {
        self.attitudeButton.selected = dish.digged_by_me;
    }
    
    // 点赞数
    self.attitudeCountLabel.text = [NSString stringWithFormat:@"%zd", [dish.ndiggs integerValue]];
}

#pragma mark - 点赞按钮点击事件
// 点赞按钮状态取反
- (void)attitude:(UIButton *)button {
    button.selected = !button.selected;
}

@end
