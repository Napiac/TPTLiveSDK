//
//  NSObject+RouterKitCategory.h
//  RouterKit
//
//  Created by Napiac on 2023/2/21.
//

#import <Foundation/Foundation.h>
#import "TPTV2RouterConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RouterKitCategory)
@property(nonatomic, copy)RouteKitCallbackBlock routeKitCallbackBlock;
@property(nonatomic, copy)RouteKitFetchBlock routeKitFetchBlock;
@end







@interface NSObject (InstanceParamsCheck)
- (NSArray *)paramsCheckPropertiesInfo;
/// 是否存在某个参数
- (BOOL)paramsCheckHasPropertyForKey:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
