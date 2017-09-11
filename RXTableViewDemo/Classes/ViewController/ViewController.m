//
//  ViewController.m
//  RXTableView
//
//  Created by laizw on 2017/9/10.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import "ViewController.h"
#import "RXTableView.h"
#import "FeedViewModel.h"

@interface ViewController ()
@property (nonatomic, strong) FeedViewModel *viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[FeedViewModel alloc] init];
    RXTableView *tableView = [[RXTableView alloc] initWithFrame:self.view.bounds];
    tableView.estimatedRowHeight = 80;
    @weakify(self);
    tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self.viewModel loadDatas];
        return [RACSignal empty];
    }];
    tableView.loadMoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self.viewModel loadMoreDatas];
        return [RACSignal empty];
    }];
    tableView.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(RACTuple *input) {
        NSLog(@"%@ did select at %@ with %@", input.first, input.second, input.third);
        return [RACSignal empty];
    }];
    
    RAC(tableView, models) = RACObserve(self.viewModel, models);
    [self.view addSubview:tableView];
    [tableView.mj_header beginRefreshing];
}

@end
