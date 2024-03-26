//
//  APPConfig.h
//  TPTManagerMoudle
//
//  Created by wangyin on 2022/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// IM系统配置
@interface AppIMSystemConfig : NSObject

/// 消息里的推送消息对应账号
@property (nonatomic, copy)NSString *im_push;
/// 消息里的活动消息对应账号
@property (nonatomic, copy)NSString *im_activity;
/// 消息里的购买进程对应账号
@property (nonatomic, copy)NSString *im_purchase;
/// 消息里的充值提醒对应账号
@property (nonatomic, copy)NSString *im_recharge;
/// 消息里的生日提醒对应账号
@property (nonatomic, copy)NSString *im_birthday;
/// 消息里的开播提醒对应账号
@property (nonatomic, copy)NSString *im_start_show;
/// 消息里的系统消息对应账号
@property (nonatomic, copy)NSString *im_system;
/// 消息里的互动通知对应账号
@property (nonatomic, copy)NSString *im_interactive_notification;
/// 消息里的最近访客对应账号
@property (nonatomic, copy)NSString *im_visitor;
/// im账号前缀
@property (nonatomic, copy)NSString *account_prefix;
/// 消息里的点赞消息对应账号
@property (nonatomic, copy)NSString *im_like;
/// 消息里的评论消息对应账号
@property (nonatomic, copy)NSString *im_comment;

@end


/// 挂机验证配置
@interface AppLiveRoomOnHookInfo : NSObject
/// 电台挂机验证开关
@property (nonatomic, assign)BOOL radio_on_hook_sta;
/// 视频挂机验证开关0关1开
@property (nonatomic, assign)BOOL video_on_hook_sta;
/// 电台验证挂机人数
@property (nonatomic, assign)NSInteger radio_on_hook_microphone_num;
/// 挂机验证聊天条数
@property (nonatomic, assign)NSInteger on_hook_msg_num;
/// 真实人数
@property (nonatomic, assign)NSInteger on_hook_user_num;
@end

/// 直播间相关配置
@interface AppLiveRoomConfig : NSObject
/// 魅力值的名字
@property (nonatomic, copy)NSString *charm_value_alias;
/// 直播间默认显示的公屏公告文案
@property (nonatomic, copy)NSString *announcement;
/// 直播间默认公共的颜色
@property (nonatomic, copy)NSString *announcement_color;
/// 挂机验证配置
@property (nonatomic, strong)AppLiveRoomOnHookInfo *on_hook_info;
/// 是否可以选择相芯美颜
@property (nonatomic, assign)BOOL canChooseFUBeauty;
/// 是否可以选择陌陌美颜
@property (nonatomic, assign)BOOL canChooseMMBeauty;
/// 陌陌授权key
@property (nonatomic, copy)NSString *mmBeautyAuth;

@end



/// 阿里云OSS配置
@interface AppAlibabaOSSConfig : NSObject
/// oss的域名
@property (nonatomic, copy)NSString *domain;
/// oss的id
@property (nonatomic, copy)NSString *access_id;
/// oss的key
@property (nonatomic, copy)NSString *access_key;
/// oss的name
@property (nonatomic, copy)NSString *bucket;
@end

/// 阿里云相关配置
@interface AppAlibabaConfig : NSObject
@property (nonatomic ,strong)AppAlibabaOSSConfig *oss;
@end


/// 抖音配置
@interface AppDouyinConfig : NSObject
/// 抖音的key
@property (nonatomic, copy)NSString *trill_key;
/// 抖音的sercet
@property (nonatomic, copy)NSString *trill_secret;
/// 抖音登录是否开启 0否1是
@property (nonatomic, assign)BOOL trill_login_status;
@end


/// 功能开关
@interface AppCircuitChangerConfig : NSObject
/// 天外物仓开关0关1开
@property (nonatomic, assign)BOOL sky_outside_ware_house_sta;
/// 财富贵族开关
@property (nonatomic, assign)BOOL noble_sta;
/// 装扮商城
@property (nonatomic, assign)BOOL dress_sta;
/// 任务中心开关1开0关
@property (nonatomic, assign)BOOL task_center_sta;
/// 三人pk的开关
@property (nonatomic, assign)BOOL third_pk_sta;
/// 4人pk的开关
@property (nonatomic, assign)BOOL four_person_microphone_switch;
/// 禁娱开关
@property (nonatomic, assign)BOOL no_entertainment_sta;
/// 活动中心
@property (nonatomic, assign)BOOL activity_center_sta;
/// 火bei开关
@property (nonatomic, assign)BOOL fire_bei_status;
/// 用户广告功能开关
@property (nonatomic, assign)BOOL advertisement_sta;
/// 广告样式切换时间 秒
@property (nonatomic, assign)NSInteger advertisement_switch;
/// 交友小屋开关
@property (nonatomic, assign)BOOL chat_anchor_sta;
/// 是否开启人脸认证
@property (nonatomic, assign)BOOL lose_face_sta;
@end

/// 直播间内小时榜、人气榜配置
@interface AppLiveHouryPopularityConfig : NSObject
/// 人气主播
@property (nonatomic, copy)NSString *popularity_list_name;
@property (nonatomic, copy)NSString *popularity_list_ranking;
/// 活跃主播
@property (nonatomic, copy)NSString *hour_list_name;
@property (nonatomic, copy)NSString *hour_list_ranking;
/// 热门主播
@property (nonatomic, copy)NSString *hot_point_list_name;
@property (nonatomic, copy)NSString *hot_point_list_ranking;
/// 头条主播
@property (nonatomic, copy)NSString *top_point_list_name;
@property (nonatomic, copy)NSString *top_point_list_ranking;



@property (nonatomic, assign)BOOL list_status;
@property (nonatomic, assign)BOOL popularity_list_status;
@property (nonatomic, assign)BOOL hour_list_status;
@property (nonatomic, assign)BOOL hot_point_list_status;
@property (nonatomic, assign)BOOL top_point_list_status;
@end


/// 小纸条功能配置
@interface APPNotesConfig : NSObject
@property (nonatomic, assign) BOOL notes_sta;
@property (nonatomic, assign) NSInteger notes_gift_id;
@end

/// 公共配置
@interface AppPublicConfig : NSObject
/// 用户靓号的名字
@property (nonatomic, copy)NSString *user_number_alias;
/// 货币的名字
@property (nonatomic, copy)NSString *money_alias;
/// ws地址
@property (nonatomic, copy)NSString *socket_address;
/// 阿里云相关配置
@property (nonatomic, strong)AppAlibabaConfig *alibaba;
/// 抖音配置
@property (nonatomic, strong)AppDouyinConfig *trill;
/// 开关
@property (nonatomic, strong)AppCircuitChangerConfig *circuit_changer;
/// 直播间小时榜、人气榜配置
@property (nonatomic, strong)AppLiveHouryPopularityConfig *hourly_popularity_config;
/// 小纸条功能配置
@property (nonatomic, strong)APPNotesConfig *notes_configure;
/// 私聊温馨提示语句
@property (nonatomic, copy)NSString *private_chat_action_msg;
/// 私聊快捷语句
@property (nonatomic, strong)NSArray <NSString *>*quick_statement_for_private_chat;

@end





/// App 配置
@interface APPConfig : NSObject

/// 消息相关配置
@property (nonatomic, strong)AppIMSystemConfig  *im_user_config;
/// 直播间相关配置
@property (nonatomic, strong)AppLiveRoomConfig  *live_room_config;
/// 公共配置
@property (nonatomic, strong)AppPublicConfig  *general;
/// 是否是审核版本
@property (nonatomic, assign)BOOL upper_shelf;
@end

NS_ASSUME_NONNULL_END
