//
//  RXTableView.m
//  RXTableView
//
//  Created by laizw on 2017/9/10.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import "RXTableView.h"
#import "RXMessageMiddleware.h"

@interface RXTableView ()
@property (nonatomic, strong) RXMessageMiddleware *delegateProxy;
@property (nonatomic, strong) RXMessageMiddleware *dataSourceProxy;
@end

@implementation RXTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self binging];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self binging];
    }
    return self;
}

- (void)binging {
    [super setDelegate:(id<UITableViewDelegate>)self.delegateProxy];
    [super setDataSource:(id<UITableViewDataSource>)self.dataSourceProxy];
    self.tableFooterView = [UIView new];
    
    @weakify(self);
    [[RACObserve(self, models) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.mj_header.isRefreshing) {
            [self.mj_header endRefreshing];
        }
        if (self.mj_footer.isRefreshing) {
            [self.mj_footer endRefreshing];
        }
        [self reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id obj = self.models[section];
    if ([obj isKindOfClass:[NSArray class]]) {
        return [obj count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<RXCellModel> *cellModel = [self cellModelAtIndexPath:indexPath];
    return [cellModel.cellClass cellForTableView:tableView cellModel:cellModel];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<RXCellModel> *cellModel = [self cellModelAtIndexPath:indexPath];
    return cellModel.cellHeight.doubleValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<RXCellModel> *cellModel = [self cellModelAtIndexPath:indexPath];
    [self.didSelectCommand execute:RACTuplePack(tableView, indexPath, cellModel)];
}

#pragma mark - Private
- (NSObject<RXCellModel> *)cellModelAtIndexPath:(NSIndexPath *)indexPath {
    id obj = self.models[indexPath.section];
    if ([obj isKindOfClass:[NSArray class]]) {
        return [obj objectAtIndex:indexPath.row];
    } else {
        return obj;
    }
}

#pragma mark - Getter && Setter
- (void)setRefreshCommand:(RACCommand *)refreshCommand {
    _refreshCommand = refreshCommand;
    @weakify(self);
    MJRefreshHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.refreshCommand execute:nil];
    }];
    self.mj_header = header;
}

- (void)setLoadMoreCommand:(RACCommand *)loadMoreCommand {
    _loadMoreCommand = loadMoreCommand;
    @weakify(self);
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.loadMoreCommand execute:nil];
    }];
    self.mj_footer = footer;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    self.delegateProxy.middleman = delegate;
    [super setDelegate:(id<UITableViewDelegate>)self.delegateProxy];
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    self.dataSourceProxy.middleman = dataSource;
    [super setDataSource:(id<UITableViewDataSource>)self.dataSourceProxy];
}

- (RXMessageMiddleware *)delegateProxy {
    if (!_delegateProxy) {
        _delegateProxy = [[RXMessageMiddleware alloc] init];
        _delegateProxy.receiver = self;
    }
    return _delegateProxy;
}

- (RXMessageMiddleware *)dataSourceProxy {
    if (!_dataSourceProxy) {
        _dataSourceProxy = [[RXMessageMiddleware alloc] init];
        _dataSourceProxy.receiver = self;
    }
    return _dataSourceProxy;
}

@end
