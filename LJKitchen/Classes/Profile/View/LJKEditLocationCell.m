//
//  LJKEditLocationCell.m
//  LJKitchen
//
//  Created by  a on 16/6/29.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKEditLocationCell.h"
#import "LJKLocation.h"
#import "LJKCity.h"

#import <Masonry.h>
@interface LJKEditLocationCell () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UITextField *locationField;
@property (nonatomic, strong) UIPickerView *locationPicker;
@property (nonatomic, strong) UILabel *locationType;
@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) NSArray *locationArray;
@property (nonatomic, assign) NSInteger index;

@end

@implementation LJKEditLocationCell

- (UITextField *)locationField {
    if (!_locationField) {
        _locationField = [[UITextField alloc] init];
        _locationField.font = [UIFont systemFontOfSize:15];
    }
    return _locationField;
}

- (UILabel *)locationType {
    if (!_locationType) {
        _locationType = [UILabel labelWithTextColor:Color_DarkGray
                                    backgroundColor:[UIColor clearColor]
                                           fontSize:13
                                              lines:1
                                      textAlignment:NSTextAlignmentRight];

        }
    return _locationType;
}

- (NSArray *)locationArray {
    if (!_locationArray) {
        NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"location" ofType:@"json"]];
        NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            LJKLocation *location = [LJKLocation locationWithDict:dict];
            [tempArr addObject:location];
        }
        _locationArray = tempArr;
    }
    return _locationArray;
}

- (UIPickerView *)locationPicker {
    if (!_locationPicker) {
        _locationPicker = [[UIPickerView alloc] init];
        _locationPicker.delegate = self;
        _locationPicker.dataSource = self;
        _locationPicker.backgroundColor = Color_BackGround;
    }
    return _locationPicker;
}

- (UIToolbar *)toolBar {
    if (!_toolBar) {
        // FIXME:(已解决) I good vegetable a! 忘了写Target...
//        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT)];
//        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"确定"
//                                                                 style:UIBarButtonItemStylePlain
//                                                                target:self
//                                                                action:@selector(done)];
//        
//        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消"
//                                                                 style:UIBarButtonItemStylePlain
//                                                                target:self
//                                                                action:@selector(cancel)];
//        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//        _toolBar.items = @[flexible,cancel,done];
//        _toolBar.tintColor = Color_ThemeColor;

        _toolBar = [UIToolbar createBasicToolBarWithDone:@selector(doneDidClicked)
                                            cancelAction:@selector(cancelDidClicked)
                                                  target:self];

        
    }
    return _toolBar;
}


#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.locationField];
        [self.contentView addSubview:self.locationType];
        
        [self setupPickerView];
        
        [_locationType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(60, 30));

        }];
        
        [_locationField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.locationType.mas_centerY);
            make.height.equalTo(self.locationType);
            make.right.equalTo(self.locationType.mas_left);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];

    }
    return self;
}

- (void)setupPickerView {
    self.locationField.inputView = self.locationPicker;
    self.locationField.inputAccessoryView = self.toolBar;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    self.locationField.placeholder = placeHolder;
}

- (void)setDisplayLocation:(NSString *)displayLocation {
    _displayLocation = displayLocation;
    self.locationField.text = displayLocation;
}

- (void)setType:(NSString *)type {
    _type = type;
    self.locationType.text = type;
}

#pragma mark - 事件处理

- (void)doneDidClicked {
    [self endEditing:YES];
    !self.editingLocationBlock ? : self.editingLocationBlock(self.locationField.text);
//     NSLog(@"点击测试——————");
}

- (void)cancelDidClicked {
//    [self endEditing:YES];
    !self.cancelEditingBlock ? : self.cancelEditingBlock(self.displayLocation);
    [self endEditing:YES];
}

#pragma mark - UIPickerView 数据源

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)  {
        return self.locationArray.count;
    }
    
    NSInteger index = [self.locationPicker selectedRowInComponent:0];
    return [[self.locationArray[index] cities] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    NSString *title;
    if (component == 0) {
        title = [self.locationArray[row] province_name];
    } else {
        NSArray *cities = [self.locationArray[self.index] cities];
        title = [cities[row] city_name];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.index = row;
        [self.locationPicker reloadComponent:1];
        [self.locationPicker selectRow:0 inComponent:1 animated:YES];
    }
    
    LJKLocation *province = self.locationArray[self.index];
    NSInteger cityIndex = [self.locationPicker selectedRowInComponent:1];
    LJKCity *city = province.cities[cityIndex];
    
    self.locationField.text = [NSString stringWithFormat:@"%@  %@", province.province_name, city.city_name];
    !self.editingLocationBlock ? : self.editingLocationBlock(self.locationField.text);
}

// cell 边距设定
- (void)setFrame:(CGRect)frame {
    frame.origin.x = 20;
    frame.size.width -= 40;
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
