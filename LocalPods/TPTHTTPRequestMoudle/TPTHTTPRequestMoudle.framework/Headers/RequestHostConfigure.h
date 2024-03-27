//
//  HTTPHostConfigure.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2022/11/21.
//

#import <Foundation/Foundation.h>
#import "ConfigureConst.h"

NS_ASSUME_NONNULL_BEGIN

static NSInteger kSelectedHTTPEnvironment;

@interface RequestHostConfigure : NSObject


/// 设置HTTP环境
/// 只需要设置一次 Default:HTTPEnvironment_Release
/// - Parameter environment: 枚举值
+ (void)setupHTTPEnvironment:(HTTPEnvironment)environment;




/// 自定义设置π框架ApiHost
+ (void)setupCustomPhaiApiHost:(NSString * _Nullable)phalApiHost;



/// 自定义设置webmanApiHost
+ (void)setupCustomWebmanApiHost:(NSString * _Nullable)webmanApiHost;



/// 根据来源获取Source
/// - Parameter host: 枚举值
+ (NSString * _Nullable)fetchHostWithSource:(HostSource)host;



@end

NS_ASSUME_NONNULL_END
