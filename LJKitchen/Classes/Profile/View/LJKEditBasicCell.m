//
//  LJKEditBasicCell.m
//  LJKitchen
//
//  Created by  a on 16/6/29.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKEditBasicCell.h"
#import <Masonry.h>

@interface LJKEditBasicCell ()
/** 主体文本编辑框 */
@property (nonatomic, strong) UITextField *textField;
@end

@implementation LJKEditBasicCell

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:15];
    }
    return _textField;
}

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [NotificationCenter addObserver:self
                               selector:@selector(textFieldEndEditing)
                                   name:UITextFieldTextDidChangeNotification
                                 object:self.textField];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.textField];
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.contentView.mas_top).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
        }];
    }
    return self;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    self.textField.placeholder = placeHolder;
}

- (void)setCurrentName:(NSString *)currentName {
    _currentName = currentName;
    self.textField.text = currentName;
}

- (void)textFieldEndEditing {
    !self.editingTextBlock ? : self.editingTextBlock(self.textField.text);
}

- (void)dealloc {
    [NotificationCenter removeObserver:self];
}

// cell 边距设定
- (void)setFrame:(CGRect)frame {
    frame.origin.x = 20;
    frame.size.width -= 40;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
