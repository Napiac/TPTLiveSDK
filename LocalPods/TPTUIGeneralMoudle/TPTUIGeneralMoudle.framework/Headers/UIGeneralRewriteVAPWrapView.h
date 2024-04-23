//
//  UIGeneralRewriteVAPWrapView.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/9.
//

/// 重写透明通道MP4文件播放器
#import <QGVAPlayer/QGVAPWrapView.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UIGeneralRewriteVAPWrapViewDelegate <NSObject>

@optional;

- (NSString *)rewriteVapWrapview_contentForVapTag:(NSString *)tag
                                         resource:(QGVAPSourceInfo *)info
                                             view:(VAPView *)view;
- (void)rewriteVapWrapView_loadVapImageWithURL:(NSString *)urlStr
                                       context:(NSDictionary *)context
                                          view:(VAPView *)view
                                    completion:(VAPImageCompletionBlock)completionBlock;

@end

@interface UIGeneralRewriteVAPWrapView : QGVAPWrapView
@property(nonatomic, strong)id rewriteConfig;
@property(nonatomic, weak) id<UIGeneralRewriteVAPWrapViewDelegate> UIGeneralRewriteDelegate;
@end

NS_ASSUME_NONNULL_END
