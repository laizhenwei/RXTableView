//
//  FeedModel.h
//  RXTableView
//
//  Created by laizw on 2017/9/11.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+RX.h"

@interface FeedModel : NSObject <RXCellModel>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;

@end
