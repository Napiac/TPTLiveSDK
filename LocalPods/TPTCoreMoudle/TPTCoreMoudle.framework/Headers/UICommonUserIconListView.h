//
//  UICommonUserIconListView.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2023/5/8.
//

#import <TPTCoreMoudle/UICommonView.h>

typedef NS_ENUM(NSInteger, UserIcon) {
    UserIcon_Unknow = 101,
    UserIcon_Gender,///性别
    UserIcon_ActiveLevel,///活跃等级
    UserIcon_VIP,
    UserIcon_WealthLevel, ///财富等级
    UserIcon_Noble, ///贵族
    UserIcon_FanGroup,///粉丝团
    UserIcon_Medal,///勋章
    UserIcon_Other
};

/// 用户性别
typedef NS_ENUM(NSInteger, UserGenderIcon) {
    UserGenderIcon_Unknow = -1,
    UserGenderIcon_Woman = 0,
    UserGenderIcon_Man
};

/// VIP状态
typedef NS_ENUM(NSInteger, UserVIPStatus) {
    UserVIPStatus_Normal = 0,
    UserVIPStatus_Month,
    UserVIPStatus_Month_Expire,
    UserVIPStatus_Year,
    UserVIPStatus_Year_Expire
};

NS_ASSUME_NONNULL_BEGIN

/// ICON基础协议
@protocol UserIconCommonProtocol <NSObject>
@required
@property(nonatomic, strong)id iconObj;
@property(nonatomic, assign)CGSize iconSize;
@property(nonatomic, assign)UserIcon userIconType;

@optional
@property(nonatomic, copy)void (^iconHandler) (id x, NSInteger index);
@property(nonatomic, strong)id extra;
@end


/// VIP特权ICON协议
@protocol UserVIPPrivilegeIconProtocol <NSObject>
@property(nonatomic, assign)UserVIPStatus vip_status;
@property(nonatomic, copy, nullable)NSString * vip_icon;
@end













@interface UserIconCommonObj : NSObject<UserIconCommonProtocol>
@end

@interface UserVIPPrivilegeIconObj : UserIconCommonObj<UserVIPPrivilegeIconProtocol>
@end









@interface UserIconListCommonProvide : NSObject
@property(nonatomic, assign)UserGenderIcon gender;
///活跃等级
@property(nonatomic, strong, nullable)UserIconCommonObj * activeLevelObj;
///VIP
@property(nonatomic, strong, nullable)id<UserVIPPrivilegeIconProtocol>vipObj;
///财富等级
@property(nonatomic, strong, nullable)UserIconCommonObj * wealthLevelObj;
///贵族
@property(nonatomic, strong, nullable)UserIconCommonObj * nobleObj;
///粉丝团
@property(nonatomic, strong, nullable)UserIconCommonObj * fanGroupObj;
///勋章
@property(nonatomic, strong, nullable)UserIconCommonObj * medalObj;

/// 清空数据
/// 在给UI赋值后会主动调用
- (void)clearData;
@end










/// 用户IconView
@interface UICommonUserIconListView : UICommonView
@end

NS_ASSUME_NONNULL_END
