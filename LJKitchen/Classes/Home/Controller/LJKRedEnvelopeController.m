//
//  LJKRedEnvelopeController.m
//  LJKitchen
//
//  Created by  a on 16/7/1.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKRedEnvelopeController.h"
#import <Masonry.h>
@interface LJKRedEnvelopeController ()
/** 红包图片 */
@property (nonatomic, strong) UIImageView *envelope;
/** 红包说明 */
@property (nonatomic, strong) UILabel *descLabel;
/** 功能性组件容器 */
@property (nonatomic, strong) UIView *containView;
/** 手机输入框 */
@property (nonatomic, strong) UITextField *mobileField;
/** 发送按钮 */
@property (nonatomic, strong) UIButton *postButton;
@end

@implementation LJKRedEnvelopeController

static NSString *descText = @"新人20元红包等你领";

- (UITextField *)mobileField {
    if (!_mobileField) {
        _mobileField = [[UITextField alloc] init];
        _mobileField.placeholder = @"请输入手机号";
        _mobileField.backgroundColor = Color_BackGround;
        _mobileField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
        _mobileField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _mobileField;
}


- (UIButton *)postButton {
    if (!_postButton) {
        _postButton = [UIButton buttonWithTitle:@"立即领取"
                                     titleColor:Color_TintWhite
                                backgroundColor:Color_ThemeColor
                                       fontSize:15
                                         target:self
                                         action:@selector(post)];
    }
    return _postButton;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupEnvelopeView];
}

- (void)setupBasic {
    self.title = descText;
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.userInteractionEnabled = YES;
    WeakSelf;
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf.mobileField endEditing:YES];
    }]];
    
    bgView.image = [UIImage imageNamed:@"redEnvelopeBackGround"];
    [self.view insertSubview:bgView atIndex:0];
    
    self.descLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                 backgroundColor:[UIColor clearColor]
                                        fontSize:20
                                           lines:1
                                   textAlignment:NSTextAlignmentCenter];
    self.descLabel.text = descText;
    [self.view addSubview:self.descLabel];

    // 按照屏幕宽度比例确定图片大小
    CGFloat redW = SCREEN_WIDTH * 0.4;
    CGFloat redH = redW * 1.25;
    self.envelope = [[UIImageView alloc] init];
    self.envelope.image = [UIImage imageNamed:@"redBag"];
    [self.view addSubview:self.envelope];
    
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT * 1.4);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, TABBAR_HEIGHT));
    }];
    
    [_envelope mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).offset(LJKAuthorIcon2CellTop);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(redW, redH));
    }];
}

- (void)setupEnvelopeView {
    self.containView = [[UIView alloc] init];
    self.containView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containView];
    [self.containView addSubview:self.mobileField];
    [self.containView addSubview:self.postButton];
    
    CGFloat margin = 5;
    CGFloat subHeight = 30;
    
    [_containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * LJKAuthorIcon2CellLeft, subHeight * 2 + margin * 3));
        make.top.equalTo(self.envelope.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [_mobileField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containView.mas_top).offset(margin);
        make.left.equalTo(self.containView.mas_left).offset(margin);
        make.right.equalTo(self.containView.mas_right).offset(-margin);
        make.height.equalTo(@(subHeight));
    }];
    
    [_postButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.mobileField);
        make.top.equalTo(self.mobileField.mas_bottom).offset(margin);
        make.left.equalTo(self.containView.mas_left).offset(margin);
        make.right.equalTo(self.containView.mas_right).offset(-margin);
    }];
    
}

#pragma mark - 点击事件
- (void)post {
    WeakSelf;
    if (!self.mobileField.hasText) { // 未输入
        UIAlertController *alertVC =
        [UIAlertController alertControllerWithTitle:@"请输入正确的手机号"
                                            message:nil
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确认"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [weakSelf.mobileField becomeFirstResponder];
                                                         }];
        
        [alertVC addAction:alert];
        [weakSelf presentViewController:alertVC animated:YES completion:nil];
    } else { // 已输入
        
        // TODO: (未完成)正则表达式判断手机号是否正确
        [UILabel showMessage:@"红包领取成功，请在您的信箱查收" atNavController:weakSelf.navigationController];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    }
}

@end
