//
//  LJKRecipeInstructionCell.m
//  LJKitchen
//
//  Created by  a on 16/7/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKRecipeInstructionCell.h"

#import "LJKRecipeInstruction.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface LJKRecipeInstructionCell ()
/** 步骤 - 步骤编号 */
@property (nonatomic, strong) UILabel *stepLabel;
/** 步骤 - 详细做法 */
@property (nonatomic, strong) UILabel *descLabel;
/** 步骤 - 步骤配图 */
@property (nonatomic, strong) UIImageView *stepImage;
@end

@implementation LJKRecipeInstructionCell

#pragma mark - 懒加载
- (UIImageView *)stepImage {
    if (!_stepImage) {
        _stepImage = [[UIImageView alloc] init];
        _stepImage.userInteractionEnabled = YES;
    }
    return _stepImage;
}

- (UILabel *)stepLabel {
    if (!_stepLabel) {
        _stepLabel = [UILabel labelWithTextColor:Color_TintBlack
                                 backgroundColor:Color_Clear
                                        fontSize:17
                                           lines:1
                                   textAlignment:NSTextAlignmentLeft];
    }
    return _stepLabel;
}


- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel labelWithTextColor:Color_TintBlack
                                 backgroundColor:Color_Clear
                                        fontSize:15
                                           lines:0
                                   textAlignment:NSTextAlignmentLeft];
    }
    return _descLabel;
}


#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.stepImage];
        [self.contentView addSubview:self.stepLabel];
        [self.contentView addSubview:self.descLabel];
        
        [_stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellTop);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        // 配图宽度 == 屏幕宽度 - (步骤label宽度(30)+padding(20)) * 2
        CGFloat stepImageWidth = SCREEN_WIDTH - 100;
        [_stepImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(stepImageWidth, stepImageWidth * 0.8));
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.stepLabel.mas_right).offset(LJKAuthorIcon2CellTop);
        }];
        
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.stepLabel.mas_right).offset(LJKAuthorIcon2CellTop);
            make.right.equalTo(self.contentView.mas_right).offset(-50);
            make.top.equalTo(self.stepImage.mas_bottom).offset(LJKAuthorIcon2CellTop);
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setInstruction:(LJKRecipeInstruction *)instruction {
    _instruction = instruction;
    
    self.stepLabel.text = [NSString stringWithFormat:@"%zd", instruction.step + 1];
    self.descLabel.text = instruction.text;
    
    if (instruction.url.length) { // 如果有配图
        self.stepImage.hidden = NO;
        [self.stepImage sd_setImageWithURL:[NSURL URLWithString:instruction.url]];
    } else {                      // 没有配图
        self.stepImage.hidden = YES;
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.stepLabel.mas_top);
            make.left.equalTo(self.stepLabel.mas_right).offset(LJKAuthorIcon2CellTop);
            make.right.equalTo(self.contentView.mas_right).offset(-50);
        }];
    }
}

@end
