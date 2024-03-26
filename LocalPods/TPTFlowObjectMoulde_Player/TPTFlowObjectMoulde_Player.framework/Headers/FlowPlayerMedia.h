//
//  FlowPlayerProtocol.h
//  TPTFlowObjectMoulde
//
//  Created by Napiac on 2022/8/31.
//



/// 播放器协议
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FlowPlayerMedia <NSObject>
/// 视频的渲染View
@property(nonatomic, weak, readonly, nullable)UIView * videoRenderView;
/// 视频地址
@property(nonatomic, copy, readonly, nullable)NSString * videoAddress;
/// 播放器静音状态 Default:NO
@property(nonatomic, assign)BOOL playerMuteStatus;
/// 播放器显示填充模式
/// NOTE:不同播放器默认值不同
@property(nonatomic, assign)NSInteger playerFillMode;
/// 当前音量
@property(nonatomic, assign)NSInteger volume;
/// 设置额外的信息
@property(nonatomic, strong)id setupExtraInfo;
/// 视频开始播放回调
@property(nonatomic, copy, nullable)void (^playerBegin) (id<FlowPlayerMedia> asset, id extra);
/// 视频播放状态回调
@property(nonatomic, copy, nullable)void (^playerStatusChanged) (id<FlowPlayerMedia> asset, BOOL isplay);
/// 视频播放大小声音回调
@property(nonatomic, copy, nullable)void (^playerVolumeUpdate) (id<FlowPlayerMedia> asset, NSInteger volume);


/// 创建一个空播放器对象
+ (id<FlowPlayerMedia>)emptyPlayerObject;

/// 初始化和反向初始化
+ (id<FlowPlayerMedia>)playerInRenderView:(UIView * _Nullable)renderView;
- (void)unInitPlayer;

/// 暂停播放
- (void)pausePlay;
/// 继续播放
- (void)resumePlay;
/// 停止播放 （不可继续播放）
- (void)stopPlay;

/// 给播放器设置渲染View
- (void)setupPlayerRenderView:(UIView * _Nullable)renderView insertIndex:(int)index;
/// 移除播放器的渲染View
- (void)removePlayerRenderView;

/// 是否正在播放
- (BOOL)isPlay;
/// 开始播放
/// @param videoLink 视频链接
- (void)startPlay:(NSString *)videoLink;

/// 设置静音
/// NOTE:必须在startPlay:后调用才会生效
- (void)setPlayMute:(BOOL)mute;

/// 设置播放器音量
/// @param volume 音量0-100
- (void)setupPlayerVolume:(NSInteger)volume;

/// 设置播放器显示填充模式
/// @param mode 填充模式
- (void)setupPlayerFillMode:(NSInteger)mode;

/// 是否存在播放器对象
- (BOOL)existPlayerObject;

@end

NS_ASSUME_NONNULL_END

