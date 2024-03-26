//
//  UserManager.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/21.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

/// 用户在线状态
typedef NS_ENUM(NSInteger, UserOnlineStatus) {
    UserOnlineStatus_NotLogin,
    UserOnlineStatus_Login
};

/// 用户在直播间状态
typedef NS_OPTIONS(NSInteger, UserInLiveRoomStatus) {
    UserInLiveRoomStatus_Leave = -1,/// 不在直播间
    
    UserInLiveRoomStatus_ShowRoom_Audience = 1 << 0,/// 秀场观众
    UserInLiveRoomStatus_AudioRoom_Audience_Single = 1 << 1,/// 单人电台房观众
    UserInLiveRoomStatus_AudioRoom_Audience_Multiple = 1 << 2,/// 多人电台房观众
    UserInLiveRoomStatus_AudioRoom_Audience_MicActivists = 1 << 3,/// 电台房上麦观众
    
    UserInLiveRoomStatus_ShowRoom_Anchor = 1 << 4,/// 秀场主播
    UserInLiveRoomStatus_AudioRoom_Anchor = 1 << 5,/// 电台房房主
    
    /// 主播
    UserInLiveRoomStatus_Anchor = UserInLiveRoomStatus_ShowRoom_Anchor |
                                  UserInLiveRoomStatus_AudioRoom_Anchor,
    /// 观众
    UserInLiveRoomStatus_Audience = UserInLiveRoomStatus_ShowRoom_Audience |
                                    UserInLiveRoomStatus_AudioRoom_Audience_Single |
                                    UserInLiveRoomStatus_AudioRoom_Audience_Multiple |
                                    UserInLiveRoomStatus_AudioRoom_Audience_MicActivists,
    
    UserInLiveRoomStatus_InRoom = UserInLiveRoomStatus_Anchor | UserInLiveRoomStatus_Audience
};

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject

@property(nonatomic, assign)UserOnlineStatus onlineStatus;
@property(nonatomic, assign)UserInLiveRoomStatus inLiveRoomStatus;
@property(nonatomic, strong, readonly, nullable)UserInfo * userInfo;

/// 用户APP渠道 (openinstall 获取)
@property(nonatomic, copy, nullable)NSString * userAPPChannel;

/// 用户设备IDFA（DeviceIDFAUtil 获取）
@property(nonatomic, copy, nullable)NSString * userDeviceIDFA;

///定位权限是否开启
@property (nonatomic, assign) BOOL locationAuthorityOpen;
///定位得到的省
@property (nonatomic, copy, nullable) NSString *province;
///定位得到的市
@property (nonatomic, copy, nullable) NSString *city;
///定位名称
@property (nonatomic, copy, nullable) NSString *adress;
///定位得到的具体位置
@property (nonatomic, copy, nullable) NSString *adressDetail;
///定位得到的纬度 (系统定位 GCJ-02)
@property (nonatomic, assign) double latitude;
///定位得到的经度 (系统定位 GCJ-02)
@property (nonatomic, assign) double longitude;


+ (instancetype)shared;
- (void)loginSuccessSetupUserInfo:(NSDictionary *)params;
- (void)logout;

- (BOOL)inRoomAnchorStatus;
- (BOOL)inRoomAudienceStatus;

/// 在电台房中
- (BOOL)inAudioRoomStatus;


- (BOOL)isVIP;
@end

NS_ASSUME_NONNULL_END
