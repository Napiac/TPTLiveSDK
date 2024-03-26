//
//  AppMenuModel.h
//  TPTManagerMoudle
//
//  Created by wangyin on 2023/2/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 菜单显示样式
typedef NS_ENUM(NSUInteger, AppMenuDisplayType) {
    /// 纯文字
    AppMenuDisplayTypeText = 0,
    /// 图片
    AppMenuDisplayTypeImage = 1,
    /// 图文混合
    AppMenuDisplayTypeTextAndImage = 2,
    /// 占位
    AppMenuDisplayTypePlaceholder = 3,
};

#pragma mark -
#pragma mark - Class 菜单跳转参数地址
@interface AppMenuModelJumpAddress : NSObject
/// iOSurl
@property (nonatomic, copy)NSString *ios_url;
/// androidUrl
@property (nonatomic, copy)NSString *android_url;
@end

#pragma mark -
#pragma mark - Class 菜单跳转参数
@interface AppMenuModelJump : NSObject
/// 打开方式
@property (nonatomic, copy)NSString *open_type;
/// 打开参数
@property (nonatomic, strong)AppMenuModelJumpAddress *jump_address;
/// ======Custom
/// 打开路由参数 只取iOS
@property (nonatomic, copy, readonly)NSString *open_url;
@end

#pragma mark -
#pragma mark - Class 菜单显示授权
@interface AppMenuModelDisplayAuth : NSObject
/// iOS是否显示
@property (nonatomic, assign)BOOL ios_display;
/// 安卓是否显示
@property (nonatomic, assign)BOOL android_display;
/// iOS审核版本是否显示
@property (nonatomic, assign)BOOL ios_verification_of_audit_version;
/// 安卓审核版本是否显示
@property (nonatomic, assign)BOOL android_verification_of_audit_version;
/// ======Custom
/// 当前是否显示
@property (nonatomic, assign, readonly)BOOL  display;
@end

#pragma mark -
#pragma mark - Class菜单图片配置
@interface AppMenuModelImage : NSObject
/// 普通模式下点击前的菜单
@property (nonatomic, copy)NSString *click_the_front_menu_image;
/// 普通模式下点击后的菜单
@property (nonatomic, copy)NSString *click_the_back_menu_image;
/// 暗黑模式下点击前的菜单
@property (nonatomic, copy)NSString *dark_click_the_front_menu_image;
/// 暗黑模式下点击后的菜单
@property (nonatomic, copy)NSString *dark_click_the_back_menu_image;
/// ======Custom
/// 默认图片 普通模式下点击前
@property (nonatomic, assign, readonly)NSString  *image;
@end

#pragma mark -
#pragma mark - Class 菜单版本显示规则 渠道 配置
@interface AppMenuModelVersionDisplayRuleChannelDetail : NSObject
///最低的版本
@property (nonatomic, copy)NSString *min_version;
///最高版本
@property (nonatomic, copy)NSString *max_version;
/// 区间内是否显示0否1是
@property (nonatomic, assign)BOOL display_status;
@end

#pragma mark -
#pragma mark - Class 菜单版本显示规则 渠道
@interface AppMenuModelVersionDisplayRuleChannel : NSObject
/// 该渠道下 iOS配置
@property (nonatomic, strong)NSArray<AppMenuModelVersionDisplayRuleChannelDetail *> *iOS;
/// 该渠道下 android配置
@property (nonatomic, strong)NSArray<AppMenuModelVersionDisplayRuleChannelDetail *> *android;
@end

#pragma mark -
#pragma mark - Class 菜单版本显示规则
@interface AppMenuModelVersionDisplayRule : NSObject
/// 通用渠道规则
@property (nonatomic, strong)AppMenuModelVersionDisplayRuleChannel *general;
/// ======Custom
/// 当前是否可用
@property (nonatomic, assign, readonly)BOOL display;
@end

#pragma mark -
#pragma mark - Class 菜单扩展字段

@interface AppMenuModelExtend : NSObject
/// 是否透明
@property (nonatomic, assign)BOOL background_transparent;

@end

#pragma mark -
#pragma mark - Class 菜单模型
@interface AppMenuModel : NSObject
/// 菜单ID
@property (nonatomic, assign)NSInteger ID;
/// 菜单标题
@property (nonatomic, copy)NSString *title;
/// 菜单副标题(存在通配符)
@property (nonatomic, copy)NSString *sub_title;
/// 菜单图标配置
@property (nonatomic, strong)AppMenuModelImage *menu_images;
/// 菜单包名授权数组
@property (nonatomic, copy)NSArray <NSString *>* display_source_auth;
/// 默认选中
@property (nonatomic, assign)BOOL default_check;
/// 进入直播间标识
@property (nonatomic, copy) NSString *join_room_type_keyword;
/// 显示授权配置
@property (nonatomic, strong)AppMenuModelDisplayAuth *display_auth;
/// 菜单样式
@property (nonatomic, assign)AppMenuDisplayType menu_type;
/// 菜单打开配置
@property (nonatomic, strong)AppMenuModelJump *jump_config;
/// 下级菜单数组
@property (nonatomic, strong)NSArray <AppMenuModel *>*down;
/// 版本显示规则
@property (nonatomic, strong)AppMenuModelVersionDisplayRule *version_display_rules;
/// 扩展信息
@property (nonatomic, strong)AppMenuModelExtend *extra;

/// 是否需要位置信息
@property (nonatomic, assign)BOOL position_status;
/// ======Custom
/// 显示的副标题
@property (nonatomic, copy, nullable)NSString * displaySubtitle;
/// 当前是否可用
@property (nonatomic, assign, readonly)BOOL available;
/// 是否在当前页面显示
@property (nonatomic, assign, readonly)BOOL isOpenInCurrentPage;
/// 要显示的控制器
@property (nonatomic, strong, readonly)UIViewController *viewController;
/// 菜单背景样式
/// 0 默认 黑色、1 透明
@property (nonatomic, assign)int menuBackgroundStyle;
@end

NS_ASSUME_NONNULL_END
