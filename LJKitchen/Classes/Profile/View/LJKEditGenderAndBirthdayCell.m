//
//  LJKEditGenderAndBirthdayCell.m
//  LJKitchen
//
//  Created by  a on 16/6/29.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKEditGenderAndBirthdayCell.h"

#import <Masonry.h>

@interface LJKEditGenderAndBirthdayCell ()

@property (nonatomic, strong) UIButton *gender_male;
@property (nonatomic, strong) UIButton *gender_female;
@property (nonatomic, strong) UIButton *gender_others;
@property (nonatomic, strong) UITextField *birthday;

@end

@implementation LJKEditGenderAndBirthdayCell

- (UIButton *)gender_male {
    if (!_gender_male) {
        _gender_male = [UIButton buttonWithTitle:@"男"
                                      titleColor:Color_DarkGray
                              selectedTitleColor:Color_TintWhite
                                        fontSize:13
                               selectedImageName:@"sexualitySegmentButtonSelected"
                                          target:self
                                          action:@selector(tapMaleButton:)];
    }
    return _gender_male;
}

- (UIButton *)gender_female {
    if (!_gender_female) {
        _gender_female = [UIButton buttonWithTitle:@"女"
                                        titleColor:Color_DarkGray
                                selectedTitleColor:Color_TintWhite
                                          fontSize:13
                                 selectedImageName:@"sexualitySegmentButtonSelected"
                                            target:self
                                            action:@selector(tapFemaleButton:)];
    }
    return _gender_female;
}

- (UIButton *)gender_others {
    if (!_gender_others) {
        _gender_others = [UIButton buttonWithTitle:@"其他"
                                        titleColor:Color_DarkGray
                                selectedTitleColor:Color_TintWhite
                                          fontSize:13
                                 selectedImageName:@"sexualitySegmentButtonSelected"
                                            target:self
                                            action:@selector(tapOtherButton:)];
    }
    return _gender_others;
}

- (UITextField *)birthday {
    if (!_birthday) {
        _birthday = [[UITextField alloc] init];
        _birthday.placeholder = @"生日";
        _birthday.font = [UIFont systemFontOfSize:15];
    }
    return _birthday;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.gender_male];
        [self.contentView addSubview:self.gender_female];
        [self.contentView addSubview:self.gender_others];
        [self.contentView addSubview:self.birthday];
        self.gender_male.selected = YES;
        
        [_gender_others mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.size.mas_equalTo(CGSizeMake(57, 30));
        }];
        
        [_gender_female mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.gender_others);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.gender_others.mas_left).offset(-5);
        }];
        
        [_gender_male mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.gender_others);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.gender_female.mas_left).offset(-5);
        }];
        
        [_birthday mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.gender_male.mas_left);
            make.top.equalTo(self.gender_others.mas_top);
            make.bottom.equalTo(self.gender_others.mas_bottom);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];

    }
    return self;
}

- (void)setDisplayGender:(NSString *)displayGender {
    _displayGender = displayGender;
    
}

- (void)setDisplayBirthday:(NSString *)displayBirthday {
    _displayBirthday = displayBirthday;
    self.birthday.text = displayBirthday;
}


#pragma mark - 事件处理 
- (void)tapMaleButton:(UIButton *)button {
    button.selected = YES;
    self.gender_others.selected = NO;
    self.gender_female.selected = NO;
}

- (void)tapFemaleButton:(UIButton *)button {
    button.selected = YES;
    self.gender_others.selected = NO;
    self.gender_male.selected = NO;
}

- (void)tapOtherButton:(UIButton *)button {
    button.selected = YES;
    self.gender_male.selected = NO;
    self.gender_female.selected = NO;
}

// cell 边距设定
- (void)setFrame:(CGRect)frame {
    frame.origin.x = 20;
    frame.size.width -= 40;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
