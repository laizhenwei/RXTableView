//
//  FeedTableViewCell.m
//  RXTableView
//
//  Created by laizw on 2017/9/11.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import "FeedTableViewCell.h"
#import <YYKit.h>
#import <Masonry.h>
#import "FeedModel.h"

#define kLazy(obj, assign) obj = obj ?: (assign)

@interface FeedTableViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation FeedTableViewCell

+ (CGFloat)cellHeightForCellModel:(FeedModel *)cellModel {
    CGSize size = [cellModel.text sizeForFont:[UIFont systemFontOfSize:16] size:CGSizeMake(kScreenWidth - 24, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping];
    return 12 + 15 + 12 + size.height + 12;
}

- (void)cellDidLoad {
    @weakify(self);
    [[RACObserve(self, cellModel) skip:1] subscribeNext:^(FeedModel *x) {
        @strongify(self);
        self.nameLabel.text = x.name;
        self.contentLabel.text = x.text;
    }];
    self.backgroundColor = UIColorHex(0xf8f8f8);
    self.contentView.backgroundColor = UIColorHex(0xffffff);
}

#pragma mark - Getter
- (UILabel *)nameLabel {
    return kLazy(_nameLabel, {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(12);
            make.left.equalTo(self.contentView).with.offset(12);
            make.height.equalTo(@(15));
        }];
        label;
    });
}

- (UILabel *)contentLabel {
    return kLazy(_contentLabel, {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel).offset(12);
            make.left.equalTo(self.contentView).offset(12);
            make.right.equalTo(self.contentView).offset(-12);
            make.bottom.equalTo(self.contentView).offset(-12);
        }];
        label;
    });
}

@end
