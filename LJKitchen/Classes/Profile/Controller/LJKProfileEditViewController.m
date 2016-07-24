//
//  LJKProfileEditViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/28.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKProfileEditViewController.h"

#import "LJKProfileEditHeader.h"            // 头像
#import "LJKEditGenderAndBirthdayCell.h"    // 生日 & 性别
#import "LJKEditBasicCell.h"                // 姓名 (基础编辑栏)
#import "LJKEditLocationCell.h"             // 地址信息
#import "LJKEditAuthorDescCell.h"           // 个性签名
#import "LJKBasicTextView.h"

#import "LJKMyInfo.h"
#import "LJKAuthorDetail.h"

@interface LJKProfileEditViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>

/** 个人信息编辑 - 头视图 */
@property (nonatomic, strong) LJKProfileEditHeader *header;
@property (nonatomic, strong) LJKAuthorDetail *authorDetail;
@property (nonatomic, assign) CGFloat headerHeight;
@end

@implementation LJKProfileEditViewController

#pragma mark - 标识符
static NSString *nickNameIdentifier          = @"nickNameCell";             // 昵称
static NSString *birthdayAndGenderIdentifier = @"birthdayAndGenderCell";    // 生日 + 性别
static NSString *homeTownIdentifier          = @"homeTownCell";             // 家乡
static NSString *residentIdentifier          = @"residentCell";             // 居住地
static NSString *authorDescIdentifier        = @"authorDescCell";           // 用户详情

#pragma mark - 懒加载
- (LJKAuthorDetail *)authorDetail {
    if (!_authorDetail) {
        _authorDetail = [LJKMyInfo info];
    }
    return _authorDetail;
}

#pragma mark - 界面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupTalbeViewHeader];
    [self setupTableView];
}

- (void)setupNavigationBar {
    self.view.backgroundColor = Color_BackGround;
    self.title = @"编辑个人资料";
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(saveProfileInfo)];
    self.navigationItem.rightBarButtonItem.tintColor = Color_ThemeColor;
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LJKEditBasicCell class] forCellReuseIdentifier:nickNameIdentifier];
    [self.tableView registerClass:[LJKEditGenderAndBirthdayCell class] forCellReuseIdentifier:birthdayAndGenderIdentifier];
    [self.tableView registerClass:[LJKEditLocationCell class] forCellReuseIdentifier:homeTownIdentifier];
    [self.tableView registerClass:[LJKEditLocationCell class] forCellReuseIdentifier:residentIdentifier];
    [self.tableView registerClass:[LJKEditAuthorDescCell class] forCellReuseIdentifier:authorDescIdentifier];
}

- (void)setupTalbeViewHeader {
    self.headerHeight = LJKAuthorIcon2CellTop * 4 + LJKAuthorIconsWH + 30;
    _header = [[LJKProfileEditHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.headerHeight)];
    _header.displayIcon = [UIImage imageNamed:self.authorDetail.photo160];
    
    UIImagePickerController *headerPicker = [[UIImagePickerController alloc] init];
    headerPicker.videoQuality = UIImagePickerControllerQualityTypeLow;
    headerPicker.delegate = self;
    headerPicker.allowsEditing = YES;
    
    WeakSelf;
    _header.uploadIconBlock = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择头像图片的来源"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        
        // 相机
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"通过拍照上传"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
               

               if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                   headerPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                   [weakSelf presentViewController:headerPicker animated:YES completion:nil];
               } else {
                   [UILabel showMessage:@"模拟器无法开启相机" atNavController:weakSelf.navigationController];
               }

        }];
        
        // 相册
        UIAlertAction *album = [UIAlertAction actionWithTitle:@"从本地图库选择"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
              if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                  headerPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                  [weakSelf presentViewController:headerPicker animated:YES completion:nil];
              }
                                                          
        }];
        
        // 取消
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
        
        [alert addAction:camera];
        [alert addAction:album];
        [alert addAction:cancel];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    self.tableView.tableHeaderView = _header;
}

#pragma mark - TableView 数据源 & 代理 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) { // 个人简介
        return 120;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeakSelf;
    
    if (indexPath.row == 0) { // 姓名
        LJKEditBasicCell *nickNameCell = [tableView dequeueReusableCellWithIdentifier:nickNameIdentifier];
        nickNameCell.currentName = self.authorDetail.name;
        nickNameCell.editingTextBlock = ^(NSString *name) {
            weakSelf.authorDetail.name = name;
        };
        
        return  nickNameCell;
        
    } else if (indexPath.row == 1) { // 性别 & 生日
        LJKEditGenderAndBirthdayCell *birthdayCell = [tableView dequeueReusableCellWithIdentifier:birthdayAndGenderIdentifier];
        birthdayCell.displayGender = self.authorDetail.gender;
        birthdayCell.displayBirthday = self.authorDetail.birthday;
        
        return  birthdayCell;
    } else if (indexPath.row == 2) { // 家乡
        LJKEditLocationCell *homeTownCell = [tableView dequeueReusableCellWithIdentifier:homeTownIdentifier];
        homeTownCell.placeHolder = @"家乡";
        homeTownCell.type = @"家乡";
        homeTownCell.displayLocation = self.authorDetail.hometown_location;
        homeTownCell.editingLocationBlock = ^(NSString *homeTownName) {
            weakSelf.authorDetail.hometown_location = homeTownName;
        };
        
        homeTownCell.cancelEditingBlock = ^(NSString *originHomeTownName) {
            weakSelf.authorDetail.hometown_location = originHomeTownName;
            [weakSelf.tableView reloadData];
        };
        return homeTownCell;
    } else if (indexPath.row == 3) { // 现居
        LJKEditLocationCell *residentCell = [tableView dequeueReusableCellWithIdentifier:residentIdentifier];
        residentCell.placeHolder = @"现居";
        residentCell.type = @"现居";
        residentCell.displayLocation = self.authorDetail.current_location;
        residentCell.editingLocationBlock = ^(NSString *residentName) {
            weakSelf.authorDetail.current_location = residentName;
//            [weakSelf.tableView reloadData];
        };
        
        residentCell.cancelEditingBlock = ^(NSString *originResidentName) {
            weakSelf.authorDetail.current_location = originResidentName;
            [weakSelf.tableView reloadData];
        };
        return residentCell;
    } else if (indexPath.row == 4) { // 自我介绍
        LJKEditAuthorDescCell *descCell = [tableView dequeueReusableCellWithIdentifier:authorDescIdentifier];
        
        descCell.editingDescBlock = ^(NSString *displayDesc) {
            weakSelf.authorDetail.desc = displayDesc;
        };
        return descCell;
    }
    return nil;
}


#pragma mark - UIImagePicker 代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    self.header.displayIcon = info[UIImagePickerControllerEditedImage];
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - scrollView 代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}

#pragma mark - 点击事件
- (void)saveProfileInfo {
    NSLog(@"保存个人信息——————");
    WeakSelf;
    if (self.authorDetail) {
        [LJKMyInfo updateInfoWithNewInfo:self.authorDetail];
        [UILabel showMessage:@"保存个人信息成功" atNavController:weakSelf.navigationController];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } else {
        [UILabel showMessage:@"保存个人信息失败，请稍后再试" atNavController:weakSelf.navigationController];
    }
}


@end
