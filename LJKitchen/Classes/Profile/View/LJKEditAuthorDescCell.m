//
//  LJKEditAuthorDescCell.m
//  LJKitchen
//
//  Created by  a on 16/7/1.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKEditAuthorDescCell.h"
#import "LJKBasicTextView.h"
#import <Masonry.h>

@interface LJKEditAuthorDescCell ()

@property (nonatomic, strong) LJKBasicTextView *authorDescTextView;

@end

@implementation LJKEditAuthorDescCell

- (LJKBasicTextView *)authorDescTextView {
    if (!_authorDescTextView) {
        _authorDescTextView = [[LJKBasicTextView alloc] init];
        _authorDescTextView.font = [UIFont systemFontOfSize:15];
        _authorDescTextView.placeholder = @"个人简介(不超过140个字)";
        _authorDescTextView.alwaysBounceVertical = YES;
    }
    return _authorDescTextView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.authorDescTextView];
        
        [_authorDescTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
        }];
    }
    return self;
}

- (void)setDisplayDescription:(NSString *)displayDescription {
    _displayDescription = displayDescription;
    self.authorDescTextView.text = displayDescription;
}

// cell 边距设定
- (void)setFrame:(CGRect)frame {
    frame.origin.x = 20;
    frame.size.width -= 40;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
