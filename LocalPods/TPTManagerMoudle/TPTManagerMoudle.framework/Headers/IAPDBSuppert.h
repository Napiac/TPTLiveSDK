//
//  IAPDBSuppert.h
//  TPTManagerMoudle
//
//  Created by Napiac on 2023/2/27.
//

#import <Foundation/Foundation.h>
@class SKPaymentTransaction;

typedef NS_ENUM(NSInteger, IAPDBDataStatus) {
    /// 等待回调
    IAPDBDataStatus_WaitCallback = 0,
    /// 等待验证
    IAPDBDataStatus_WaitVerify,
    /// 异常
    IAPDBDataStatus_Unusual,
    /// 结束
    IAPDBDataStatus_Finish,
};

NS_ASSUME_NONNULL_BEGIN

@interface IAPDBObject : NSObject
@property(nonatomic, copy)NSString * iapId;
@property(nonatomic, copy, nullable)NSString * userId;
@property(nonatomic, copy, nullable)NSString * orderId;
@property(nonatomic, copy, nullable)NSString * receipt;
/// 事务Id
@property(nonatomic, copy, nullable)NSString * transactionId;
@property(nonatomic, copy, nullable)NSString * extJson;
@property(nonatomic, copy, nullable)NSString * createTime;
@property(nonatomic, assign)IAPDBDataStatus status;


#pragma mark -
#pragma mark - Custom
@property(nonatomic, strong)SKPaymentTransaction * transaction;
@end





@interface IAPDBSuppert : NSObject


/// SKPayment携带的参数
/// - Parameter orderId: OrderId
- (NSString *)paymentBringParamsString:(NSString *)orderId;


/// 创建订单成功
/// - Parameter orderId: orderId
- (BOOL)createIAPOrderSuccessWithOrderId:(NSString *)orderId;



/// 成功获取到付款事务
/// - Parameters:
///   - transaction: 事务
///   - receipt: 事务中的票据
///   - orderId: 当前OrderId
- (BOOL)successFetchPaymentTransaction:(SKPaymentTransaction *)transaction
                    transactionReceipt:(NSString *)receipt
                        currentOrderId:(NSString * _Nullable)orderId;

///// 成功获取到票据
///// - Parameters:
/////   - receipt: 票据
/////   - orderId: 订单Id
//- (BOOL)successFetchIAPOrderReceipt:(NSString *)receipt
//                     currentOrderId:(NSString * _Nullable)orderId;



/// 查询实体类
- (NSArray <IAPDBObject *>*)queryIPDBOjbects;



/// 根据主键移除这次内购存储的数据
/// - Parameter iapId: IAPDBObject.iapId
- (BOOL)removeIAPObjectWithIapId:(NSString *)iapId;



/// 根据OrderId移除这次内购存储的数据
/// - Parameter orderId: 订单Id
- (BOOL)removeIAPObjectWithOrderId:(NSString *)orderId;
@end

NS_ASSUME_NONNULL_END
