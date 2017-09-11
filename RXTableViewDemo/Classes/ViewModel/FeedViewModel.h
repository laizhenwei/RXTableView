//
//  FeedViewModel.h
//  RXTableView
//
//  Created by laizw on 2017/9/11.
//  Copyright © 2017年 laizw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface FeedViewModel : NSObject

@property (nonatomic, copy) NSArray *models;

- (void)loadDatas;
- (void)loadMoreDatas;

@end
