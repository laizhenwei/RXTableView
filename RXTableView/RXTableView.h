//
//  RXTableView.h
//  RXTableView
//
//  Created by laizw on 2017/9/10.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>
#import <MJRefresh.h>
#import "NSObject+RX.h"
#import "UITableViewCell+RX.h"

@interface RXTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *models;

@property (nonatomic, strong) RACCommand *refreshCommand;
@property (nonatomic, strong) RACCommand *loadMoreCommand;
@property (nonatomic, strong) RACCommand *didSelectCommand;

@end
