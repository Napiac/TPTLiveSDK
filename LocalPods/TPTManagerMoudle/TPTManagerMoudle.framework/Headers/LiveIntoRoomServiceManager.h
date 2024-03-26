//
//  LiveIntoRoomService.h
//  TPTManagerMoudle
//
//  Created by Napiac on 2022/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 进入房间条件-返回结构体
typedef struct IntoRoomConditionResultStruct {
    BOOL enable;
    NSString * _Nonnull message;
} IntoRoomConditionResultStruct;


/// NOTE：
/// Block跟Protocol不同在于Block是App全局的；Protocol是针对遵守对象的，当遵守对象被释放时,条件也不存在

/// 进入房间条件Block
/// - Parameters:
///   - currentRoomId: 当前房间号（可为空）
///   - nextRoomId: 下面房间号
typedef IntoRoomConditionResultStruct(^IntoRoomConditionHandler) (NSString * _Nullable currentRoomId, NSString * nextRoomId);


@protocol IntoRoomConditionCategory <NSObject>

/// 进入房间条件协议方法
/// - Parameters:
///   - currentRoomId: 当前房间号（可为空）
///   - nextRoomId: 下面房间号
- (IntoRoomConditionResultStruct)intoRoomContidionWithCurrentRoomId:(NSString * _Nullable)currentRoomId
                                                         nextRoomId:(NSString *)nextRoomId;

@end



@protocol IntoRoomServiceCategory <NSObject>

@optional;

/// 观众端控制器创建成功
/// @param controller 观众端控制器
- (void)viewersControllerInitializationSuccess:(UIViewController *)controller;


/// 跳转观众端成功
/// @param controller 观众端控制器
- (void)pushViewersControllerSuccess:(UIViewController *)controller;


/// 进房结果
/// @param result YES:成功 、 NO:失败
/// @param roomOwnerUserId 房主的UserId
- (void)joinRoomResult:(BOOL)result roomOwnerUserId:(NSString *)roomOwnerUserId;


/// 已经存在的观众端准备销毁
/// NOTE:可以做一些静默操作 （暂停视频、断开WS）
- (void)prepareUnInitializationalreadyExistsViewersController:(UIViewController *)controller
                                              roomOwnerUserId:(NSString *)roomOwnerUserId;


/// 销毁存在的观众端
/// NOTE:由LiveIntoRoomServiceManager Hook'joinRoomResult:forRoomOwnerUserId:'进房结果来调用
- (void)unInitializationExistsViewersController:(UIViewController *)controller
                                roomOwnerUserId:(NSString *)roomOwnerUserId;


/// 进入新房间失败 恢复存在的直播间
/// NOTE:由LiveIntoRoomServiceManager Hook'joinRoomResult:forRoomOwnerUserId:'进房结果来调用
- (void)recoveryExistsViewersController:(UIViewController *)controller
                        roomOwnerUserId:(NSString *)roomOwnerUserId;

@end



@protocol LiveIntoRoomServiceManagerDelegate <NSObject>

@optional

/// 直播间加入失败
/// - Parameter error: 错误
- (void)liveIntoRoomJoinFailWithError:(NSError *)error;

@end


@interface RoomContext : NSObject
/// 房主UserId
@property(nonatomic, copy)NSString * roomOwnerUserId;
/// 进房来源
@property(nonatomic, copy, nullable)NSString * joinRoomKeyword;
/// 房间封面
@property(nonatomic, copy)NSString * roomCoverURLString;
/// 跳转的控制器
@property(nonatomic, weak, nullable)UIViewController * targetViewController;
/// 退出房间显示的控制器 Default：targetViewController
@property(nonatomic, weak, nullable)UIViewController * exitRoomDisplayViewController;
/// 上次进入直播间使用的导航栏控制器
@property(nonatomic, weak, readonly, nullable)UINavigationController * lastPushNavigationController;

+ (RoomContext *)context:(NSString *)userId;

+ (RoomContext *)context:(NSString *)userId joinKeyword:(NSString *)keyword;

@end





@interface LiveIntoRoomServiceManager : NSObject
/// 保存的直播间 Key:UserId Value:观众端VC
@property(nonatomic, strong, readonly)NSMutableDictionary <NSString *, UIViewController *> * savedRoom;
/// 进入房间的条件
@property(nonatomic, copy, nullable)IntoRoomConditionHandler intoConditionHandler;
@property(nonatomic, weak, nullable)id <IntoRoomConditionCategory> conditionDelegate;
@property(nonatomic, strong, readonly)RoomContext * lastContext;
@property(nonatomic, weak)id <LiveIntoRoomServiceManagerDelegate> delegate;

+ (instancetype)shared;
+ (NSError *)willJoinRoom:(RoomContext *)context;
+ (void)willQuitRoom:(NSString *)roomOwnerUserId;
+ (BOOL)willUpdateCacheKey:(NSString *)key forValue:(UIViewController *)value;
@end

NS_ASSUME_NONNULL_END
