//
//  AppMenuRouteObjectInitializationProtocol.h
//  TPTManagerMoudle
//
//  Created by wangyin on 2023/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AppMenuModel;


@protocol AppMenuRouteObjectInitializationProtocol <NSObject>

- (void)setupEntityObject:(AppMenuModel *)menuModel;

@end

NS_ASSUME_NONNULL_END
