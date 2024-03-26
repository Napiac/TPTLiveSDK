//
//  FlowTRTCConnect.h
//  TPTFlowObjectMoulde
//
//  Created by Napiac on 2022/10/19.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef NS_ENUM(NSInteger, TRTCConnectRole) {
    /// 主播
    TRTCConnectRole_Anchor = 10101,
    /// 上麦人
    TRTCConnectRole_MicActivists,
    /// 普通用户
    TRTCConnectRole_User
};

@class FlowTRTCConnectListenerWrapper;

NS_ASSUME_NONNULL_BEGIN

@interface FlowTRTCConnect : NSObject
@property(nonatomic, strong, readonly)FlowTRTCConnectListenerWrapper * listenerWrapper;

- (void)setupTRTCRoomId:(NSString *)roomId
           inRoomUserId:(NSString *)userId
               userSign:(NSString *)userSign;


/// 主播创建房间
- (RACSignal *)createTRTCRoom;


/// 用户加入房间
- (RACSignal *)joinTRTCRoomWithRole:(TRTCConnectRole)role;


/// 退出房间
- (RACSignal *)quitTRTCRoom;


/// 准备修改用户在房间内的权限
/// @param nowRole 现在的权限
/// @param newRole 新权限
- (void)prepareUpdateUserRole:(TRTCConnectRole)nowRole
                    inNewRole:(TRTCConnectRole)newRole;


/// 开启/关闭用户本地音频的采集和发布
/// @param enable YES:打开、NO:关闭
- (void)userEnableAudioStream:(BOOL)enable;


/// 延迟执行修改用户本地音频的采集和发布
/// @param enable YES:打开 NO:关闭
/// @param delay 延时时间
- (void)userEnableAudioStream:(BOOL)enable afterDelay:(CGFloat)delay;


/// 暂停、恢复发布本地的音频流
/// @param mute YES:暂停 NO:恢复
- (void)userMuteLocalAudio:(BOOL)mute;


/// 延迟执行暂停、恢复发布本地的音频流
/// @param mute YES:暂停 NO:恢复
/// @param delay 延时时间
- (void)userMuteLocalAudio:(BOOL)mute afterDelay:(CGFloat)delay;


/// 静音、取消静音房间里的某个用户
/// @param userId userID
/// @param mute YES:静音、NO:取消静音
- (void)updateRoomUserMuteStatusWithUserId:(NSString *)userId
                                muteStatus:(BOOL)mute;


/// 静音房间内容所有用户
/// @param mute YES:静音、NO:取消静音
- (void)muteAllRemoteAudio:(BOOL)mute;
@end

NS_ASSUME_NONNULL_END
