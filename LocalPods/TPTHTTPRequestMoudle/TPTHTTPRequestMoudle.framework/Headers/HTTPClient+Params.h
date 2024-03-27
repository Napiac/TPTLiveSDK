//
//  HTTPClient+Params.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2022/7/28.
//

#import <TPTHTTPRequestMoudle/HTTPClient.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTTPClient (Params)

/// 每次请求的编号(随机字符编码)
@property(nonatomic, copy)NSString * requestNumber;
/// 用户凭证(TOKEN)
@property(nonatomic, copy)NSString * userCertificate;
/// 请求签名串最后的Key -- 有默认值
@property(nonatomic, copy)NSString * requestSignLastKey;

/// 保存额外添加的公共参数数组
@property(nonatomic, strong)NSMutableArray * commonParamsAddBlocks;

/// 追加签名的参数数组（会参与签名），跟上方commonParamsAddBlocks不同
@property(nonatomic, strong)NSMutableArray * signParamsAddBlocks;

/// HTTP公参(非业务参数)
- (NSDictionary *)HTTPPublicParams;




/// 添加业务参数
/// @param params 业务参数
- (NSDictionary *)addBusinessParams:(NSDictionary *)params;






/// 整理请求数据
/// 如果传入的数据是NSMutableDictionary直接调用
/// 如果传入的数据是NSDictionary还需要重新赋值（self.params = [HTTPClient.shared organizeRequestParams:nowParams]）
/// - Parameter nowParams: 现在的数据
- (NSMutableDictionary *)organizeRequestParams:(NSMutableDictionary *)nowParams;





/// 获取Signature
/// @param params 请求参数
- (NSString *)fetchSignatureInRequestParams:(NSDictionary *)params;




/// 添加公共参数Block
/// @param block 公共参数block
- (void)addCommonParamsWithBlock:(NSDictionary <NSString *, NSString *>*_Nullable(^)(void))block;




/// 加密参数
- (NSString *)HTTPEncryptString;

@end

NS_ASSUME_NONNULL_END
