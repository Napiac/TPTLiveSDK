//
//  UIGeneralRouterSend.m
//  AFNetworking
//
//  Created by Napiac on 2023/3/2.
//

#import "UIGeneralRouterSend.h"
#import <TPTV2RouterMoudle/TPTV2RouterMoudle.h>
#import <TPTV2RouterMoudle/RouteInstanceProtocol.h>

/// wechat 分享
/// @param title 标题
/// @param description 描述
/// @param openUrl 分享链接
/// @param scene 场景 0 好友列表 1朋友圈
/// @param imgData 封面图
void UIGeneral_StartWechatShareWithParams(NSString * _Nullable title,
                                          NSString * _Nullable description,
                                          NSString * _Nullable openUrl,
                                          int scene,
                                          NSData *imgData) {
    RouteRequestParam *routeParams = [RouteRequestParam new];
    routeParams.title = @"share";
    routeParams.parameters = @{@"title":title,
                               @"description":description,
                               @"openUrl":openUrl,
                               @"scene":@(scene),
                               @"shareImageData":imgData
    };
    RouteRequest *openInstallRequest = [[RouteRequest alloc] initWithPath:@"StaticLibrary/WechatManager/Share"
                                                               parameters:routeParams];
    
    [[RouterKit shared] instanceWithRequest:openInstallRequest
                          completionHandler:^(NSObject * _Nullable result,
                                              RouteRequest * _Nullable request,
                                              NSError * _Nullable error) {
        if (![request isEqual:openInstallRequest]) {
            return;
        }
        if (error) {
            return;
        }
    }];
    
}

/// 发送请求
/// - Parameter param: 请求参数
void UIGeneral_New3YHTTPReuqest(RouteRequestParam * param,HTTPRequestHandler handler) {
    if (!param) {
        return;
    }
    RouteRequest * request = [[RouteRequest alloc] initWithPath:@"HTTP/Post" parameters:param];
    [RouterKit.shared instanceWithRequest:request
                        completionHandler:^(id result, RouteRequest * xRequest, NSError * error) {
        if (![xRequest isEqual:request]) {
            error = [NSError errorWithDomain:@"Request失败"
                                        code:404
                                    userInfo:nil];
            handler(error);
            return;
        }
        if (![result isKindOfClass:NSDictionary.class] || error) {
            handler(error);
            return;
        }
        
        handler ? handler(result) : nil;
    }];
}
