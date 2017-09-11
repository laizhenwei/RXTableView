//
//  NSObject+RX.h
//  RXTableView
//
//  Created by laizw on 2017/9/10.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCell+RX.h"

@protocol RXCellModel <NSObject>

@optional
/**
 绑定 model 对应需要显示的 CellClass
 */
@property (nonatomic, unsafe_unretained) Class<RXTableViewCell> cellClass;

/**
 缓存 cell 的高度，为 nil 时会调用 [cellClass cellHeightForCellModel:self]
 */
@property (nonatomic, strong) NSNumber *cellHeight;

@end

@interface NSObject (RX)

@end
