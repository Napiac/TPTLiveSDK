//
//  RouterKit+Runtime.h
//  Pods-TPTV2RouterMoudle_Example
//
//  Created by Napiac on 2023/3/3.
//

#import "RouterKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface RouterKit (Runtime)

/// 根据参数通过Runtime取得目标对象
/// @param jumpURLPath 跳转地址
- (NSObject *)instanceWithThirdPartyURLPath:(NSString *)jumpURLPath;



/// 根据Class获取目标对象
/// @param className Class
- (NSObject *)instanceWithClassName:(NSString *)className;
@end

NS_ASSUME_NONNULL_END
