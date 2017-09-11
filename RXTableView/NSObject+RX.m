//
//  NSObject+RX.m
//  RXTableView
//
//  Created by laizw on 2017/9/10.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import "NSObject+RX.h"
#import <objc/message.h>

@implementation NSObject (RX)

- (void)setCellClass:(Class)cellClass {
    objc_setAssociatedObject(self, @selector(cellClass), NSStringFromClass(cellClass), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (Class)cellClass {
    return NSClassFromString(objc_getAssociatedObject(self, _cmd));
}

- (void)setCellHeight:(NSNumber *)cellHeight {
    objc_setAssociatedObject(self, @selector(cellHeight), cellHeight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)cellHeight {
    NSNumber *cellHeight = objc_getAssociatedObject(self, _cmd);
    if (!cellHeight) {
        cellHeight = @([self.cellClass cellHeightForCellModel:(id<RXCellModel>)self]);
        self.cellHeight = cellHeight;
    }
    return cellHeight;
}

@end
