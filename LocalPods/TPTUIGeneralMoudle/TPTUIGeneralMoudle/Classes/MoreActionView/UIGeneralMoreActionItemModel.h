//
//  UIGeneralMoreActionItem.h
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIGeneralMoreActionItemModel;

typedef void(^UIGeneralMoreActionItemHander)(UIGeneralMoreActionItemModel *itemModel);

/// item类型
typedef NS_ENUM(NSUInteger, UIGeneralMoreActionItemType) {
    UIGeneralMoreActionItemTypeShare = 0,//分享
    UIGeneralMoreActionItemTypeReport,//举报
    UIGeneralMoreActionItemTypeSendMessage,//私信
    UIGeneralMoreActionItemTypeBlack,//拉黑
    UIGeneralMoreActionItemTypeCustom = 99//自定义
};

/// 底部弹出item viewmodel 模型
@interface UIGeneralMoreActionItemModel : NSObject
///类型
@property(nonatomic, assign)UIGeneralMoreActionItemType actionItemType;
///标题
@property(nonatomic, copy)NSString *title;
/// 图标image
@property(nonatomic, strong)UIImage *iconImage;
///点击事件
@property(nonatomic, copy)UIGeneralMoreActionItemHander eventHander;

/// 是否是switch开关样式
@property(nonatomic, assign)BOOL isSwitchStyle;
@property(nonatomic, assign)BOOL switchIsOn;

/// 分享item
+ (instancetype)defalutShareItemModelWithHander:(UIGeneralMoreActionItemHander)eventHander;
/// 举报item
+ (instancetype)defalutReportItemModelWithHander:(UIGeneralMoreActionItemHander)eventHander;
/// 私信item
+ (instancetype)defalutSendMessageItemModelWithHander:(UIGeneralMoreActionItemHander)eventHander;
/// 拉黑Item
+ (instancetype)defalutBlackItemModelWithHander:(UIGeneralMoreActionItemHander)eventHander;

/// 构建itemmodel
/// @param iconImage 图标
/// @param title 标题
/// @param hander 点击事件
+ (instancetype)itemModelWithIcon:(nullable UIImage *)iconImage
                            title:(nullable NSString *)title
                           hander:(nullable UIGeneralMoreActionItemHander)hander;

@end

NS_ASSUME_NONNULL_END
