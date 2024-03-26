//
//  CoreRouterSend.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2023/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 发送Log
/// @param name Log名字
/// @param description 详情
void CoreRouterSend_SendLogDescription(NSString * name, NSString * description);



/// 用户开播
void CoreRouterSend_UserStartLive(void);


/// 调用分享
/// @param shareTitle 分享标题
/// @param shareDesc 分享描述
/// @param sharePath 分享链接
/// @param shareImage 分享图片地址
void CoreRouterSend_Share(NSString * shareTitle,
                          NSString * shareDesc,
                          NSString * sharePath,
                          id shareImage);

/// 进入直播间
/// @param roomUserId 房间主播的UserId (必传)
/// @param roomCoverString 房间封面
/// @param targetController TargetVC
NSObject * CoreRouterSend_IntoRoom(NSString * roomUserId,
                                   NSString * _Nullable roomCoverString,
                                   UIViewController * _Nullable targetController);



/// 进入个人中心
/// @param userId userid (不传默认自己)
UIViewController * _Nullable CoreRouterSend_ToUserCenterController(NSString * userId);


/// Vue、PHP让APP跳转
/// @param appOpen 打开方式
/// @param jumpURLPath 跳转参数
NSObject * CoreRouterSend_ThirdPartyJump(NSString * appOpen, NSString * jumpURLPath);


/// 获取当前用户UserId
NSString * _Nullable CoreRouterSend_FetchCurrentUserId(void);


/// 用户当前用户Token
NSString * _Nullable CoreRouterSend_FetchCurrentToken(void);


/// 获取用户在直播间状态
BOOL CoreRouterSend_FetchUserInLiveRoomStatus(void);


/// 获取 LiveIntoRoomServiceManager的直播间状态
NSDictionary * _Nullable CoreRouterSend_FetchRoomsData(void);


/// 根据Class获取对象实例
/// - Parameter ClassName: Class名字
NSObject * _Nullable CoreRouterSend_FetchObject(NSString * className);



/// 弹出VIP弹框
/// - Parameters:
///   - paddingView: PaddingView
///   - giveUserParam: 赠送人的信息{userid/avatar/nickname}
///   - giveSuccessNotifierURLPath: 赠送成功的VIP回调地址
void CoreRouterSend_PopBuyVIPProductModal(UIView * _Nullable paddingView,
                                          NSDictionary * _Nullable giveUserParam,
                                          NSString * _Nullable giveSuccessNotifierURLPath);

/// 弹出VIP弹框(可以设置弹出View)
/// - Parameters:
///   - showingView: 展示的View(Default：Window)
///   - paddingView: PaddingView
///   - giveUserParam: 赠送人的{userid/avatar/nickname}
///   - giveSuccessNotifierURLPath: 赠送成功的VIP回调地址
void CoreRouterSend_PopBuyVIPProductModalAppointShowingView(UIView * _Nullable showingView,
                                                            UIView * _Nullable paddingView,
                                                            NSDictionary * _Nullable giveUserParam,
                                                            NSString * _Nullable giveSuccessNotifierURLPath);

/// 获取VIP产品列表
NSArray * _Nullable CoreRouterSend_FetchVIPProductList(void);


/// 购买VIP
/// - Parameter productIdentifier: VIP产品id
void CoreRouterSend_BuyVIPProduct(NSString * productIdentifier);


/// 去私聊界面
/// - Parameter toUserId: 用户的userid
void CoreRouterSend_ToUserMessageVC(NSString * toUserId);

NS_ASSUME_NONNULL_END
