//
//  LiveBraceRouterSend.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by wansheng on 2023/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceRouterSend : NSObject

/// 个人中心
UIViewController * _Nullable LiveBrace_MineController(NSString * userId);

///开播
void LiveBrace_StartLive(void);

/// 礼物面板
/// @param targetVC 来自哪个vc
/// @param params 参数
void LiveBrace_ShowGiftController(UIViewController * targetVC, NSDictionary *params);


/// 进入直播间
/// @param userid 主播userid
/// @param cover 直播间封面图
/// @param controller 控制器
void LiveBrace_EnterLiveRoom(NSString *userid, NSString *cover, UIViewController * _Nullable controller);


@end

NS_ASSUME_NONNULL_END
