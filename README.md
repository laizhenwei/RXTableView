#  RXTableView

RXTableView 是基于 ReactiveCocoa 和 MVVM 的基础上造的一个 tableView 轮子。

抛弃繁杂重复的 TableView 代理实现和 Cell 管理，加入灵活的数据绑定，`RXTableView` 是一种新的体验。

### WorkFlow

> 在 MVVM 编程中，View 负责显示，Model 负责模型，它们都是相对比较稳定的，一般不会轻易改动代码。
> ViewModel 主要是负责业务，一般的数据获取、加工和绑定都是在这里完成。

在使用 RXTableView 中，你只需要完成 4 个步骤:

1. 定义 Model，并遵循 `RXCellModel` 协议
2. 添加自定义 UITableViewCell，并实现 `+ (CGFloat)cellHeightForCellModel:(id<RXCellModel>)cellModel` 方法
3. 在 ViewModel 中获取数据，并绑定 `cellClass`
4. 创建 RXTableView，并绑定相关命令和 `ViewModel` 的数据源

#### 定义 Model

自定义 Model 并遵循 `RXCellModel`

`RXCellModel` 的协议方法已经在分类中实现，自定义 Model 无需自己实现

```objc
#import "NSObject+RX.h"

@interface FeedModel : NSObject <RXCellModel>
// ...
@end
```

#### 添加自定义 `UITableViewCell`

自定义 `UITableViewCell`，并参照 `RXTableViewCell` 的协议方法，按需实现。

`RXTableViewCell` 的协议方法已在分类中实现

自定义 Cell 需要实现 `+ (CGFloat)cellHeightForCellModel:(id<RXCellModel>)cellModel` 方法返回 Cell 的高度。

- 自动计算高度

```objc
+ (CGFloat)cellHeightForCellModel:(id<RXCellModel>)cellModel {
    return UITableViewAutomaticDimension;
}

// 自动计算高度需要给 estimatedRowHeight 赋一个近似值
tableView.estimatedRowHeight = 100;
```

#### 绑定 `cellClass`

```objc
// 获取数据
NSArray *models = [NSArray modelArrayWithClass:[FeedModel class] json:data];
for (FeedModel *model in models) {
    // 绑定 CellModel 和 Cell
   model.cellClass = NSClassFromString(@"FeedTableViewCell");
    // 预加载高度
   [model cellHeight];
}

// 更新数据源
self.models = models;
```

#### 创建 TableView

```objc
// 创建 viewModel
self.viewModel = [[FeedViewModel alloc] init];
// 创建 tableView
RXTableView *tableView = [[RXTableView alloc] initWithFrame:self.view.bounds];

// 绑定下拉刷新命令
tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    ...
}];
// 绑定上拉加载命令
tableView.loadMoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    ...
}];
// 绑定选中 cell 命令
tableView.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(RACTuple *input) {
    ...
}];

// 数据源绑定
RAC(tableView, models) = RACObserve(self.viewModel, models);

// 显示 tableView 并加载数据
[self.view addSubview:tableView];
[tableView.mj_header beginRefreshing];
```

#### 自定义实现数据源和代理方法

RXTableView 对 `dataSource` 和 `delegate` 做了中转处理，会优先使用用户自定义的代理，其次才会使用 `RXtableView` 自身实现的代理方法。

如果你需要自己实现 `UITableViewDataSource` 或者 `UITableViweDelegate`，那么你可以把它当做 `UITableView` 来使用。

```objc
@implementation ViewController
// ...
- (void)registerTableView {
    tableView.dataSource = self;
    tableView.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 点击 Cell 后会忽略 didSelectCommand，进入该方法
}
// ...
@end
```

### 项目依赖

- [ReactiveObjc](https://github.com/ReactiveCocoa/ReactiveObjC)
- [MJRefresh](https://github.com/CoderMJLee/MJRefresh)

