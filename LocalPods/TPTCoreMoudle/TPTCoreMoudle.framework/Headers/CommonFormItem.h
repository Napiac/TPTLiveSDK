//
//  CommonItem.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/21.
//  Copyright © 2022 Napiac. All rights reserved.
//

///基础类
#import <Foundation/Foundation.h>

@class RACBehaviorSubject;
typedef void(^ItemHandler)(_Nullable id value);

NS_ASSUME_NONNULL_BEGIN

@interface CommonFormItem : NSObject
@property(nonatomic, strong, nullable)id value;
@property(nonatomic, copy)ItemHandler handler;
@property(nonatomic, strong)RACBehaviorSubject *subject;
@property(nonatomic, strong)Class cellClass;
/** Default:50.f*/
@property(nonatomic, assign)CGFloat cellHeight;


+ (instancetype)itemWithClass:(Class)cellClass;

+ (instancetype)itemWithClass:(Class)cellClass
                   cellHeight:(CGFloat)height
                        value:(nullable id)value
                      handler:(nullable ItemHandler)handler;
@end

NS_ASSUME_NONNULL_END
