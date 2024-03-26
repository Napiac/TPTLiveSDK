//
//  UIGeneralMoreActionItem.m
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/8/25.
//

#import "UIGeneralMoreActionItemModel.h"
#import "TPTUIGeneralMoudle.h"

@implementation UIGeneralMoreActionItemModel
/// 分享item
+ (instancetype)defalutShareItemModelWithHander:(UIGeneralMoreActionItemHander)eventHander{
    UIGeneralMoreActionItemModel *model = [self itemModelWithIcon:UIGeneralBusinessBundleLoadImage(@"icon_share")
                                                            title:@"分享"
                                                            hander:eventHander];
    model.actionItemType = UIGeneralMoreActionItemTypeShare;
    return model;
}
/// 举报item
+ (instancetype)defalutReportItemModelWithHander:(UIGeneralMoreActionItemHander)eventHander{
    UIGeneralMoreActionItemModel *model = [self itemModelWithIcon:UIGeneralBusinessBundleLoadImage(@"icon_report")
                                                            title:@"举报"
                                                            hander:eventHander];
    model.actionItemType = UIGeneralMoreActionItemTypeReport;
    return model;
}
/// 私信item
+ (instancetype)defalutSendMessageItemModelWithHander:(UIGeneralMoreActionItemHander)eventHander{
    UIGeneralMoreActionItemModel *model = [self itemModelWithIcon:UIGeneralBusinessBundleLoadImage(@"icon_msg")
                                                            title:@"私信"
                                                            hander:eventHander];
    model.actionItemType = UIGeneralMoreActionItemTypeSendMessage;
    return model;
}
/// 拉黑Item
+ (instancetype)defalutBlackItemModelWithHander:(UIGeneralMoreActionItemHander)eventHander{
    UIGeneralMoreActionItemModel *model = [self itemModelWithIcon:UIGeneralBusinessBundleLoadImage(@"icon_lhei")
                                                            title:@"拉黑"
                                                            hander:eventHander];
    model.actionItemType = UIGeneralMoreActionItemTypeBlack;
    return model;
}

/// 构建itemmodel
/// @param iconImage 图标
/// @param title 标题
/// @param hander 点击事件
+ (instancetype)itemModelWithIcon:(nullable UIImage *)iconImage
                            title:(nullable NSString *)title
                           hander:(nullable UIGeneralMoreActionItemHander)hander{
    UIGeneralMoreActionItemModel *model = [[UIGeneralMoreActionItemModel alloc] init];
    model.title = title;
    model.iconImage = iconImage;
    model.eventHander = hander;
    model.actionItemType = UIGeneralMoreActionItemTypeCustom;
    return model;
}
@end
