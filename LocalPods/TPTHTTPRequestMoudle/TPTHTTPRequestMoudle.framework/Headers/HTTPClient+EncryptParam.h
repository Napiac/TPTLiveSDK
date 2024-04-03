//
//  HTTPClient+EncryptParam.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2023/3/20.
//

/// HTTP加密参数结构体
typedef struct HTTPEncryptParamStruct {
    NSString * _Nonnull encryptKey;
    NSString * _Nonnull encryptIv;
    NSString * _Nonnull encryptName;
} HTTPEncryptParamStruct;

#import <TPTHTTPRequestMoudle/TPTHTTPRequestMoudle.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTTPClient (EncryptParam)
- (HTTPEncryptParamStruct)encryptParamStruct;
@property(nonatomic, assign)HTTPEncryptParamStruct customEncryptStruct;

@end

NS_ASSUME_NONNULL_END
