//
//  GeneralWSRouterSend.h
//  TPTGeneralWebsocketBusinessModule
//
//  Created by wangyin on 2023/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeneralWSRouterSend : NSObject
/// 查询是否开启ws记录显示开关
BOOL GeneralWsRecordSwitchIsOpen(void);

/// ws触发封禁相关弹窗
/// - Parameters:
///   - title: 标题
///   - conetnt: 副标题
void GeneralWsShowBanWaringModal(NSString *title,NSString *conetnt);

@end

NS_ASSUME_NONNULL_END
