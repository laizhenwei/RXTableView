//
//  RXMessageMiddleware.h
//  AFNetworking
//
//  Created by laizw on 2017/9/11.
//

#import <Foundation/Foundation.h>

@interface RXMessageMiddleware : NSObject

@property (nonatomic, weak) id middleman;
@property (nonatomic, weak) id receiver;

@end
