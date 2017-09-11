//
//  UITableViewCell+RX.m
//  RXTableView
//
//  Created by laizw on 2017/9/10.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import "UITableViewCell+RX.h"
#import <objc/message.h>

@implementation UITableViewCell (RX)

+ (void)load {
    Method original = class_getInstanceMethod(self.class, @selector(initWithStyle:reuseIdentifier:));
    Method swizzled = class_getInstanceMethod(self.class, @selector(rx_initWithStyle:reuseIdentifier:));
    method_exchangeImplementations(original, swizzled);
}

- (instancetype)rx_initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    UITableViewCell *cell = [self rx_initWithStyle:style reuseIdentifier:reuseIdentifier];
    [cell cellDidLoad];
    return cell;
}

#pragma mark - RXCellModel
+ (void)registerCellWithTableView:(UITableView *)tableView identify:(NSString *)identify {
    [tableView registerClass:self forCellReuseIdentifier:identify];
}

+ (instancetype)cellForTableView:(UITableView *)tableView cellModel:(id<RXCellModel>)cellModel {
    NSString *identify = NSStringFromClass(self.class);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        [self registerCellWithTableView:tableView identify:identify];
        cell = [tableView dequeueReusableCellWithIdentifier:identify];
    }
    cell.cellModel = cellModel;
    return cell;
}

+ (CGFloat)cellHeightForCellModel:(id<RXCellModel>)cellModel {
    return 0;
}

- (void)cellDidLoad {
    
}

#pragma mark - Getter & Setter
- (void)setCellModel:(id<RXCellModel>)cellModel {
    objc_setAssociatedObject(self, @selector(cellModel), cellModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<RXCellModel>)cellModel {
    return objc_getAssociatedObject(self, _cmd);
}

@end
