//
//  LJKHomeHeader.m
//  LJKitchen
//
//  Created by  a on 16/6/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKHomeHeader.h"
#import "LJKHomeHeaderTopNav.h"
#import "LJKHomeHeaderNavButton.h" // 自定义导航按钮

#import "LJKHomeHeaderDish.h"
#import "LJKNavContent.h"
#import "LJKPopEvent.h"
#import "LJKPopEvents.h"
#import "LJKDish.h"

#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface LJKHomeHeader () <UIScrollViewDelegate>
/** 首页header - 流行菜谱 */
@property (nonatomic, strong) LJKHomeHeaderTopNav *popular_TopNavLeft;
/** 首页header - 查找关注 */
@property (nonatomic, strong) LJKHomeHeaderTopNav *friend_TopNavRight;
/** 首页header - 导航按钮组（容器） */
@property (nonatomic, strong) UIView *navButtonsView;
/** 首页header - 三餐(容器) */
@property (nonatomic, strong) UIView *dishNavView;
/** 首页header - 三餐滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 首页header - 新用户优惠 */
@property (nonatomic, strong) UIButton *fristAuthorButton;
/** 首页header - ScrollView - pageControl */
@property (nonatomic, strong) UIPageControl *pageControl;
/** 首页header - 导航按钮个数 */
@property (nonatomic, assign) NSUInteger count;

@end

@implementation LJKHomeHeader

#pragma mark - 懒加载
- (LJKHomeHeaderTopNav *)popular_TopNavLeft {
    if (!_popular_TopNavLeft) {
        _popular_TopNavLeft = [LJKHomeHeaderTopNav imageViewWithTitle:@"本周流行菜谱"
                                                                target:self
                                                               action:@selector(popular)];
    }
    return _popular_TopNavLeft;
}

- (LJKHomeHeaderTopNav *)friend_TopNavRight {
    if (!_friend_TopNavRight) {
        _friend_TopNavRight = [LJKHomeHeaderTopNav imageViewWithTitle:@"关注动态"
                                                               target:self
                                                               action:@selector(friend)];
    }
    return _friend_TopNavRight;
}

- (UIView *)navButtonsView {
    if (!_navButtonsView) {
        _navButtonsView = [[UIView alloc] init];
        _navButtonsView.backgroundColor = Color_Clear;
    }
    return _navButtonsView;
}

- (UIButton *)fristAuthorButton {
    if (!_fristAuthorButton) {
        _fristAuthorButton = [UIButton buttonWithTitle:@"新用户优惠20元"
                                            titleColor:Color_ThemeColor
                                       backgroundColor:Color_ThemeColor_Yellow
                                              fontSize:21
                                                target:self
                                                action:@selector(buttonDidClicked:)];
        _fristAuthorButton.tag = 10;
        
    }
    return _fristAuthorButton;
}

- (UIView *)dishNavView {
    if (!_dishNavView) {
        _dishNavView = [[UIView alloc] init];
    }
    return _dishNavView;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = Color_ThemeColor;
    }
    return _pageControl;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.popular_TopNavLeft];
        [self addSubview:self.friend_TopNavRight];
        [self addSubview:self.navButtonsView];
        [self addSubview:self.fristAuthorButton];
        [self addSubview:self.dishNavView];
        [self.dishNavView addSubview:self.scrollView];
        [self.dishNavView addSubview:self.pageControl];
        
        // 顶部左侧 本周流行
        [_popular_TopNavLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.height.equalTo(@(LJKHomeHeader_TopNav_Height));
            make.width.equalTo(self.mas_width).offset(-0.5).multipliedBy(0.5);
        }];
        
        // 顶部右侧 查找关注
        [_friend_TopNavRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.height.equalTo(self.popular_TopNavLeft);
            make.width.equalTo(self.popular_TopNavLeft);
        }];
    
        // 导航按钮组
        [_navButtonsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.popular_TopNavLeft.mas_bottom);
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@(LJKHomeHeader_CenterNav_Height));
        }];
        
        
        // 红包
        [_fristAuthorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self.navButtonsView.mas_bottom);
            make.height.equalTo(@(LJKHomeHeader_NewAuthor_Height));
        }];
        
        // 三餐
        [_dishNavView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fristAuthorButton.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@(LJKHomeHeader_BottomNav_Height));
        }];
        
        // 滚动视图
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.dishNavView);
        }];
        
        // 页面控制器 (位于scrollView 中下部)
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.dishNavView);
            make.centerY.equalTo(self.dishNavView.mas_bottom).offset(-10);
        }];

    }
    return self;
}

#pragma mark - 传入模型
- (void)setDish:(LJKDish *)dish {
    _dish = dish;
    // 下载Header右侧顶部图片
    [self.friend_TopNavRight sd_setImageWithURL:[NSURL URLWithString:dish.thumbnail]];
}

- (void)setNavContent:(LJKNavContent *)navContent {
    _navContent = navContent;
    // 流行菜谱图片
    [self.popular_TopNavLeft sd_setImageWithURL:[NSURL URLWithString:navContent.pop_recipe_picurl]];
    
    // 添加4个导航按钮
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat buttonWidth = self.navButtonsView.frame.size.width / navContent.navs.count;
    for (NSInteger index = 0; index < navContent.navs.count; index++) {
        LJKHomeHeaderNavButton *button = [LJKHomeHeaderNavButton buttonWithNav:navContent.navs[index]
                                                                        target:self
                                                                        action:@selector(buttonDidClicked:)];
        
        x = index * buttonWidth;
        button.frame = CGRectMake(x, 0, buttonWidth, buttonWidth);
        button.tag = index + 2;
        [self.navButtonsView addSubview:button];
    }
    
    
    // 添加三餐导航 (滚动视图)
    // FIXME: (已解决)官方后台返回的数据会根据时间段的变换而增加
    // For example: 凌晨至正午前 popEvents.count == 1(只有早餐)  00:00 前 popEvents.count = 3(早中晚)
    // 吐槽: 突然就从3页变成1页了，还以为自己写错了……  似乎是更傻瓜式了，但感觉怪怪的
    LJKPopEvents *popEvents = navContent.pop_events;
    self.count = popEvents.count;
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    CGFloat scrollViewheight = LJKHomeHeader_BottomNav_Height;
    for (NSInteger index = 0; index < popEvents.count; index++) {
        LJKHomeHeaderDish *dishView = [LJKHomeHeaderDish viewWithPopEvent:popEvents.events[index]
                                                                    target:self
                                                                    action:@selector(viewDidClicked:)];
        x = index * scrollViewWidth;
        dishView.frame = CGRectMake(x, y, scrollViewWidth, scrollViewheight);
        dishView.tag = index + 6;
        [self.scrollView addSubview:dishView];
    }
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth * popEvents.count, 0);
    self.pageControl.numberOfPages = popEvents.count;
    
}

#pragma mark - Header 各位置 点击事件
/** 顶部左侧本周流行菜谱 */
- (void)popular {
    !self.clickBlock ? : self.clickBlock(viewDidClickedActionPopularImageView);
}

/** 顶部右侧关注状态（朋友圈……） */
- (void)friend {
//    if (self.clickBlock) {
//        self.clickBlock(viewDidClickedActionFeedsView);
//    }
    !self.clickBlock ? : self.clickBlock(viewDidClickedActionFeedsView);
}

/** 中部导航按钮(4个 根据tag区别) */
- (void)buttonDidClicked:(LJKHomeHeaderNavButton *)sender {
    !self.clickBlock ? : self.clickBlock(sender.tag);
}

/** 中部导航按钮(3个 根据tag区别) */
// 官方后台增加了时间段判定，可以根据当前时间段(清晨、正午、午夜)直接跳转至对应page
- (void)viewDidClicked:(id)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    !self.clickBlock ? : self.clickBlock(tap.view.tag);
}

#pragma mark - ScrollView 代理方法 (同步)
/** pageControl同步 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = self.scrollView.frame.size.width;
    self.pageControl.currentPage = (scrollView.contentOffset.x + width * 0.5) / width;
}
@end
