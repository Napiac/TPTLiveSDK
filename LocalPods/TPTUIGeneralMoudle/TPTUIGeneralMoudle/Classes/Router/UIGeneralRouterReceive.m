//
//  UIGeneralRouterReceive.m
//  AFNetworking
//
//  Created by Napiac on 2023/3/2.
//

#import "UIGeneralRouterReceive.h"
#import <TPTV2RouterMoudle/TPTV2RouterMoudle.h>
#import <TPTCoreMoudle/UICommonEaseOutModal.h>

#import "UIGeneralRouterSend.h"
#import "UIGeneralLoadingView.h"
#import "TPTUIGeneralShareView.h"

@interface UIGeneralRouterReceive ()<RouteHandler>

@end

@implementation UIGeneralRouterReceive

+ (NSArray<NSString *> *)multiRoutePath {
    return @[[self _showLoadingRequestURLPath],
             [self _showShareRequestURLPath]];
}


+ (void)instanceWithRequest:(RouteRequest *)request
          completionHandler:(CompletionHandler)completionHandler {
    id result = nil;
    if ([request.requestPath isEqualToString:[self _showLoadingRequestURLPath]]) {
        result = @([self _handlerLoadingReuqest:request]);
    }
    if ([request.requestPath isEqualToString:[self _showShareRequestURLPath]]) {
        result = [self _handlerShareRequest:request];
    }
    completionHandler ? completionHandler(result, request, nil) : nil;
}


+ (NSObject *)syncInstanceWithRequest:(RouteRequest *)request {
    id result = nil;
    if ([request.requestPath isEqualToString:[self _showLoadingRequestURLPath]]) {
        result = @([self _handlerLoadingReuqest:request]);
    }
    if ([request.requestPath isEqualToString:[self _showShareRequestURLPath]]) {
        result = [self _handlerShareRequest:request];
    }
    return result;
}



+ (NSString *)_showLoadingRequestURLPath {
    return @"UIGeneral/ShowLoading";
}


+ (NSString *)_showShareRequestURLPath {
    return @"UIGeneral/ShowShare";
}


+ (BOOL)_handlerLoadingReuqest:(RouteRequest *)request {
    BOOL showStatus = [request.parameters.parameters[@"status"] boolValue];
    UIView * showView = request.parameters.ext;
    if (![showView isKindOfClass:UIView.class] && !showView) {
        return NO;
    }
    NSString * loadingText = request.parameters.title;
    if (showStatus) {
        [UIGeneralLoadingView showLoadingInView:showView loadingText:loadingText];
    } else {
        [UIGeneralLoadingView removeFromView:showView];
    }
    return YES;
}

+ (TPTUIGeneralShareView *)_handlerShareRequest:(RouteRequest *)request {
    NSDictionary * params = request.parameters.parameters;
    if (params[@"url"] == nil) {
        return nil;
    }
    TPTUIGeneralShareView * shareView = [[TPTUIGeneralShareView alloc] initDefaultItems];
    NSString *thirdId = @([params[@"third_id"] integerValue]).stringValue;
    NSString *shareType = params[@"share_type"];
    @weakify(shareView);
    [shareView setShareCompletion:^(ShareEnum shareEnum) {
        @strongify(shareView);
        if (shareView.routeKitCallbackBlock){
            shareView.routeKitCallbackBlock(@"share", @(shareEnum));
        }
        if (thirdId.length > 0 && shareType.length > 0){
            [UIGeneralRouterReceive shareCallBackWithThridID:thirdId
                                                   shareType:shareType
                                                 shareSource:shareEnum];
        }
    }];
    [shareView setupShareInfoWithTitle:params[@"title"]
                           description:params[@"cont"]
                              imgeIcon:params[@"img"]
                               openUrl:params[@"url"]];
    [shareView showWithMaskView:[self fetchKeyWindow]];
    return shareView;
}



/// 处理分享回调
/// - Parameters:
///   - thridId: 数据ID
///   - shareType: 分享类型
///   - shareEnum: 分享渠道
+ (void)shareCallBackWithThridID:(NSString *)thridId
                       shareType:(NSString *)shareType
                     shareSource:(ShareEnum)shareEnum{
    RouteRequestParam * param = [RouteRequestParam new];
    param.title = @"/api/CallBack/callShare";
    NSString *shareSource = @"wechat";
    switch (shareEnum) {
        case ShareEnum_Wechat:
            shareSource = @"wechat_moments";
            break;
        case ShareEnum_WechatFriend:
            shareSource = @"wechat";
            break;
        case ShareEnum_QQ:
            shareSource = @"qq";
            break;
        case ShareEnum_QQZone:
            shareSource = @"qzone";
            break;
        default:
            break;
    }
    NSDictionary * params = @{
        @"keyword":shareType,
        @"third_id":@([thridId integerValue]),
        @"share_source":shareSource
    };
    param.parameters = params;
    UIGeneral_New3YHTTPReuqest(param, ^(id  _Nullable response) {});
}
@end
