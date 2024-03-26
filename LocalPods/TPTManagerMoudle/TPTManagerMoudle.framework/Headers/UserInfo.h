//
//  UserInfo.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/21.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserLoginSignModel : NSObject

@property(nonatomic, copy)NSString * appid;
@property(nonatomic, copy)NSString * sign;
@property(nonatomic, copy)NSString * userid;

@end

/// 用户广告
@interface UserAdverModel : NSObject
@property (nonatomic, copy)NSString *jump_type;
@property (nonatomic, copy)NSString *android_url;
@property (nonatomic, copy)NSString *ios_url;
@property (nonatomic, copy)NSString *ID;
#pragma mark-
#pragma mark-Custom
@property(nonatomic, assign)BOOL isDownloadType;
@end

/// 标签
@interface UserTagModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *ID;
@end

@interface UserVIPInfo : NSObject
@property(nonatomic, assign)NSInteger vip_status;
@property(nonatomic, copy)NSString * vip_icon;
@end

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *token;
/// 用户ID
@property (nonatomic, copy) NSString *user_id;
/// 用户ID
@property (nonatomic, copy) NSString *userid;

/// 用户昵称
@property (nonatomic, copy) NSString *nick_name;
/// 性别
@property (nonatomic, copy) NSString *gender;
/// 年龄
@property (nonatomic, copy) NSString *age;
/// 头像
@property (nonatomic, copy) NSString *head_portrait;
/// 头像框
@property (nonatomic, copy) NSString *head_portrait_box;
///app币数量
@property (nonatomic, copy) NSString *balance;
/// 用户靓号
@property (nonatomic, copy) NSString *user_number;
/// 用户靓号
@property (nonatomic, copy) NSString *usernumber;
/// 是否是语聊主播
@property (nonatomic, assign) BOOL is_chat_anchor;
/// 语聊主播设置的语聊在线状态
@property (nonatomic, assign) BOOL is_chat_online;

/// 是否主播0否大于0的都是 0:用户 1:线上主播 2:线下主播
@property (nonatomic, copy) NSString *is_achor;
/// 主播认证状态 0没有去申请认证，1未通过，2审核中，3通过了主播认证
@property (nonatomic, copy) NSString *anchor_auth_sta;
/// 身份认证0没绑1绑了
@property (nonatomic, copy) NSString *user_auth_sta;
///是否开启青少年模式
@property (nonatomic, copy) NSString *adolescent_model;
/// 个性签名
@property (nonatomic, copy) NSString *personal_signature;
///生日
@property (nonatomic, copy) NSString *birthday;
/// 关注数量
@property (nonatomic, copy) NSString *my_follow_num;
/// 关注我的数量
@property (nonatomic, copy) NSString *follow_me_number;
/// 粉丝数量
@property (nonatomic, copy) NSString *fans_num;
/// 播放量
@property (nonatomic, copy) NSString *general_play_count;

/// 手机号
@property (nonatomic, copy, nullable)NSString *mobile;
/// 微信昵称
@property (nonatomic, copy, nullable)NSString *wechat_name;

/// 绑定手机状态0没绑1绑了
@property (nonatomic, copy) NSString *bind_phone_sta;
/// 绑定微信的状态0没1绑
@property (nonatomic, copy) NSString *bind_wechat_sta;


/// 所在省份
@property (nonatomic, copy) NSString *province;
///城市
@property (nonatomic, copy) NSString *city;
/// 是否可以查看喜欢列表
@property (nonatomic ,copy) NSString *is_show_like;
/// 达人信息
@property (nonatomic, copy) NSString *talent_name;
/// 企业认证信息
@property (nonatomic, copy) NSString *confirm_name;
/// 隐私设置-主页关注列表是否私密
@property (nonatomic, assign) BOOL display_follow_sta;
///是否是新注册用户
@property (nonatomic, assign) BOOL isRegisterTag;
/// 聊天账户信息
@property(nonatomic, strong)UserLoginSignModel * im_sign_info;
/// 广告信息
@property (nonatomic, strong, nullable) UserAdverModel *advertisement_all;

@property(nonatomic, strong)UserVIPInfo * vip;
/// 是否开启广告
@property (nonatomic, assign) BOOL advertisement_sta;

/// 年龄是否公开
@property (nonatomic, assign) BOOL age_sta;
/// 所在地是否公开
@property (nonatomic, assign) BOOL location_sta;
/// 主播称号是否公开
@property (nonatomic, assign) BOOL anchor_title_sta;


/// 用户标签数据
@property (nonatomic, strong)NSArray <UserTagModel *>*label_data;

/// 初始化UserInfo
/// @param params 参数
+ (UserInfo * _Nullable)infoWithParams:(NSDictionary *)params;


/// 修改值
/// @param key key
/// @param value value
- (BOOL)updateInfoWithKey:(NSString *)key value:(id)value;


/// 修改所有Key-Value
/// @param params parmas
- (BOOL)updateTotalParams:(NSDictionary *)params;


/// 修改所有的Key-Value
/// @param params params
/// @param enable 是否启用修改资料的通知
- (BOOL)updateTotalParams:(NSDictionary *)params enableUpdateNotifier:(BOOL)enable;


/// 清空所有数据
- (BOOL)clearUserInfo;

@end

NS_ASSUME_NONNULL_END
