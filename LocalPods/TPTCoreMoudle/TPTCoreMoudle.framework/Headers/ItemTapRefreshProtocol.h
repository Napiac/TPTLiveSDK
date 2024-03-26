//
//  ItemTapRefreshProtocol.h
//  TPTCoreMoudle
//
//  Created by wansheng on 2022/10/15.
//  Item 被点击时刷新协议

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RefreshStatus) {
    RefreshStatus_Unknown, ///未知
    RefreshStatus_Progress, ///正在刷新
    RefreshStatus_End, ///结束
};

typedef void(^RefreshFinishBlock)(void);


@protocol ItemTapRefreshProtocol <NSObject>
@optional

@property (nonatomic, copy, nullable) RefreshFinishBlock finishBlock;

///准备刷新
///@param finish 刷新完成的Block回调
- (void)prepareRefreshWithFinishHandler:(RefreshFinishBlock)finish;


///是否满足刷新的条件
- (BOOL)whetherRefreshCondition;

///刷新完成的回调
- (void)refreshFinishCallBack;

@end

NS_ASSUME_NONNULL_END
