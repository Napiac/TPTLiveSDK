//
//  InitializationProtocol.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol InitializationProtocol <NSObject>

@optional;

/// View初始化
+ (instancetype)createView;
+ (instancetype)createViewWithFrame:(CGRect)frame;


- (void)initializationUserInterface;
- (void)initializationUserSource;
- (void)initializationNavigationBar;


/// 给View设置Model实体
- (void)setupEntityObject:(id)object;
@end

NS_ASSUME_NONNULL_END
