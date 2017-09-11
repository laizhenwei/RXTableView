//
//  UITableViewCell+RX.h
//  RXTableView
//
//  Created by laizw on 2017/9/10.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RXCellModel;
@protocol RXTableViewCell <NSObject>

/**
 计算 Cell 高度，默认为 0，会被 CellModel 缓存
 调用方式为 - [cellModel cellHeight]，建议提前调用缓存高度

 @param cellModel cellModel
 @return cellHeight
 */
+ (CGFloat)cellHeightForCellModel:(id<RXCellModel>)cellModel;

/**
 cell 创建完成回调
 */
- (void)cellDidLoad;


/**
 注册 Cell（ 非必要实现 ）
 默认调用 registerClass:forCellReuseIdentifier:
 使用 xib 或需要手动注册的需要实现该方法
 
 @param tableView tableView
 @param identify identify
 */
+ (void)registerCellWithTableView:(UITableView *)tableView identify:(NSString *)identify;


/**
 数据源方法
 不建议实现该方法，请在重写 setCellModel: 设置 Cell

 @param tableView tableView
 @param cellModel cellModel
 @return cell
 */
+ (instancetype)cellForTableView:(UITableView *)tableView cellModel:(id<RXCellModel>)cellModel;


@end

@interface UITableViewCell (RX) <RXTableViewCell>

@property (nonatomic, strong) id<RXCellModel> cellModel;

@end
