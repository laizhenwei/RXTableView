//
//  FeedViewModel.m
//  RXTableView
//
//  Created by laizw on 2017/9/11.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import "FeedViewModel.h"
#import "FeedModel.h"
#import <YYKit.h>

@implementation FeedViewModel

- (void)loadDatas {
    @weakify(self);
    [[RACScheduler currentScheduler] afterDelay:2 schedule:^{
        @strongify(self);
        self.models = [self fakeDatas];
    }];
}

- (void)loadMoreDatas {
    @weakify(self);
    [[RACScheduler currentScheduler] afterDelay:3 schedule:^{
        @strongify(self);
        NSArray *models = [self fakeDatas];
        NSMutableArray *arr = self.models.mutableCopy;
        [arr addObject:models];
        self.models = arr;
    }];
}

- (NSArray *)fakeDatas {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *models = [NSArray modelArrayWithClass:[FeedModel class] json:data];
    for (FeedModel *model in models) {
        model.cellClass = NSClassFromString(@"FeedTableViewCell");
        [model cellHeight];
    }
    return models;
}

@end
