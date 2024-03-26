//
//  TPTUIGeneralShareView.h
//  FDFullscreenPopGesture
//
//  Created by Napiac on 2022/8/13.
//

/// 分享的弹框 - 内部使用UICommonEaseOutModal
#import <TPTCoreMoudle/UICommonView.h>
#import "TPTUIGeneralShareFormItem.h"

typedef void(^ShareCompletion)(ShareEnum shareEnum);

NS_ASSUME_NONNULL_BEGIN

/// 分享内容模型
@interface TPTUIGeneralShareInfo : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,strong)id img;
@property(nonatomic,copy)NSString *url;
///扩展信息 动态id等
@property(nonatomic,strong)id extData;

@end










@interface TPTUIGeneralShareView : UICommonView

- (instancetype)initDefaultItems;
- (instancetype)initDefaultItemsWithCompletion:(ShareCompletion _Nullable)completion;
- (instancetype)initWithItems:(NSArray <TPTUIGeneralShareFormItem *> * _Nullable)items
             shareComplateion:(ShareCompletion _Nullable)completion;
- (void)showWithMaskView:(UIView * _Nullable)view;

- (void)shareToWechat;
- (void)shareToWechatFriend;
@property(nonatomic, copy)ShareCompletion shareCompletion;


/// 设置分享参数
/// @param title 标题
/// @param description 描述
/// @param img 图片
/// @param url 网址
- (void)setupShareInfoWithTitle:(NSString *)title
                    description:(NSString *)description
                       imgeIcon:(id)img
                        openUrl:(NSString *)url;
/// 设置分享参数
/// @param info obj
- (void)setupShareInfoWithObj:(TPTUIGeneralShareInfo *)info;

@end

NS_ASSUME_NONNULL_END
