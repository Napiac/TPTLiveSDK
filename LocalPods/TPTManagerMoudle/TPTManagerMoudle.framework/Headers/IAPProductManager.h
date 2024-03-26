//
//  IAPServiceManager.h
//  TPTBANGProject
//
//  Created by Napiac on 2022/8/22.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <StoreKit/StoreKit.h>
@class IAPDBObject;


/// 产品列表获取成功的通知
FOUNDATION_EXPORT NSString * _Nullable const kIAP_Notifier_Product_FetchSuccess;
/// 钻石购买成功的通知
FOUNDATION_EXPORT NSString * _Nullable const kIAP_MoneyProduct_Notifier_PurchaseSuccess;
/// VIP购买成功的通知:object{@"userId"/@"orderId"/@"message"}
FOUNDATION_EXPORT NSString * _Nullable const kIAP_VIPProduct_Notifier_PurchaseSuccess;


@interface SKProduct (Display)

/// 显示内购产品带货币符号金额
- (NSString * _Nullable)displayLocalePrice;

@end




@protocol IAPServiceManagerDelegate <NSObject>
/// 购买有结果了
- (void)buyProductCallback;
@end



NS_ASSUME_NONNULL_BEGIN

@interface IAPProductManager : NSObject
@property(nonatomic, weak)id<IAPServiceManagerDelegate>delegate;
@property(nonatomic, strong, readonly)NSArray <SKProduct *>* rechargeProducts;
@property(nonatomic, strong, readonly)NSArray <SKProduct *>* vipProducts;

+ (instancetype)shared;
- (void)startListener;
- (void)stopListener;


/// 获取充值产品
- (void)fetchIPARechargeProductListWithIdentifiers:(NSSet *)productIdentifiers;
/// 获取VIP产品
- (void)fetchIAPVIPProductListWithIdentifiers:(NSSet *)productIdentifiers;
- (void)resetFetchIPAProduct;


/// 根据产品Id购买
- (void)buyProductWithProductIdentifier:(NSString *)productIdentifier;

/// 购买产品
/// 默认给自己购买
- (void)buyProduct:(SKProduct *)product;

/// 购买产品
/// - Parameters:
///   - product: 产品模型
///   - toUserId: 给指定用户购买
- (void)buyProduct:(SKProduct *)product
          toUserId:(NSString * __nullable)toUserId;
@end

NS_ASSUME_NONNULL_END
