//
//  RouteInstanceComplyProtocol.h
//  RouterKit
//
//  Created by Napiac on 2023/2/21.
//

/// 路由获取的实例可遵守协议
#import <Foundation/Foundation.h>
#import "TPTV2RouterConst.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RouteInstanceProtocol <NSObject>
@optional



/// 路由实例设置参数方法
/// - Parameters:
///   - params: 参数
///   - fetchBlock: 获取Block
///   - callbackBlock: 回调Block
- (void)instanceSetupParams:(id)params;

- (void)instanceSetupParams:(id)params
                 fetchBlock:(RouteKitFetchBlock _Nonnull)fetchBlock
              callbackBlock:(RouteKitCallbackBlock _Nonnull)callbackBlock;

@end

NS_ASSUME_NONNULL_END
