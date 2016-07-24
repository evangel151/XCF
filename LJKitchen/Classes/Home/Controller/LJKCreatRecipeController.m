//
//  LJKCreatRecipeController.m
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKCreatRecipeController.h"
//#import "LJKBasicTextView.h"

#import <Masonry.h>

@interface LJKCreatRecipeController ()<UITextFieldDelegate>
/** 输入框 */
@property (nonatomic, strong) UITextField *textView;
/** 副标题(固定) */
@property (nonatomic, strong) UILabel *descLabel;
/** 帮助按钮 */
@property (nonatomic, strong) UIButton *draftBox;
@end

@implementation LJKCreatRecipeController


#pragma mark - 懒加载
- (UITextField *)textView {
    if (!_textView) {
        _textView = [[UITextField alloc] init];
        _textView.placeholder = @"在此添加菜谱名称";
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
        // 键盘通知
        [NotificationCenter addObserver:self
                               selector:@selector(textDidChange)
                                   name:UITextFieldTextDidChangeNotification
                                 object:_textView];

    }
    return _textView;
}


- (UIButton *)draftBox {
    if (!_draftBox) {
        _draftBox = [UIButton buttonWithTitle:@"草稿箱"
                                       titleColor:Color_TintWhite
                                  backgroundColor:Color_ThemeColor
                                         fontSize:17
                                           target:self
                                           action:@selector(goDraftBox)];
    }
    return _draftBox;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel labelWithTextColor:Color_DarkGray
                                     backgroundColor:[UIColor clearColor]
                                            fontSize:13
                                               lines:0
                                       textAlignment:NSTextAlignmentCenter];
    }
    return _descLabel;
}

#pragma mark - 页面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupSubviews];
}

- (void)setupNavigationBar {
    self.title = @"菜谱名称";
    self.view.backgroundColor = Color_BackGround;
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = Color_ThemeColor;
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"创建"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(createRecipe)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

// 加载控制器子控件 (fake)
- (void)setupSubviews {
    [self.view addSubview:self.textView];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.draftBox];
    self.descLabel.text = @"(创建菜谱的人都是创房里的天使)";
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH * 0.5, 50));
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(35);
        make.right.equalTo(self.view.mas_right).offset(-35);
        make.height.equalTo(self.textView.mas_height);
    }];
    
    [_draftBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(50));
    }];
}

#pragma mark - 点击事件
- (void)goDraftBox {
     NSLog(@"即将挑战至草稿箱——————");
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createRecipe {
     NSString *name = self.textView.text;
     NSLog(@"即将跳转菜谱>>> %@ <<<界面——————",name);
}

#pragma mark - 键盘通知相关逻辑
- (void)textDidChange {
    if (self.textView.hasText) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.tintColor = Color_ThemeColor;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self];
}

@end
