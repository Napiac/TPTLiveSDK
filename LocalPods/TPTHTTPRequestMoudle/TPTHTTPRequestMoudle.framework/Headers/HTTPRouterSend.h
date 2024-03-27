//
//  HTTPRouterHelper.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2022/9/29.
//

#import <Foundation/Foundation.h>
#import "HTTPClient+EncryptParam.h"

@class HTTPCommonRequest;
NS_ASSUME_NONNULL_BEGIN



/// 获取当前用户Token
NSString * _Nullable HTTPRouterSend_FetchCurrentUserToken(void);


/// 当前用户退出登录
void HTTPRouterSend_LogoutCurrentUser(void);


/// 发送错误请求的详情
void HTTPRouterSend_V2ErrorReuqestDescription(HTTPCommonRequest * request, NSError * error);


/// 发送停服公告
void HTTPRouterSend_StopServiceDescription(void);


/// AES加密
/// - Parameters:
///   - paramStruct: 加密的参数
///   - ext: 加密的内容
NSString * HTTPRouterSend_AESEncrypt(HTTPEncryptParamStruct paramStruct, NSString * ext);


/// AES解密
/// - Parameters:
///   - paramStruct: 解密的参数
///   - ext: 解密的内容
NSObject * HTTPRouterSend_AESEecryption(HTTPEncryptParamStruct paramStruct, NSString * ext);


/// 加密/编码、解密/解码
/// - Parameters:
///   - index: 加密类型
///   - type: 0=加密/编码(Default) 1=解密/解码
///   - ext: 加密的内容
NSString * HTTPRouterSend_GeneralEncrypt(NSInteger index, NSInteger type, NSString * ext);

NS_ASSUME_NONNULL_END
