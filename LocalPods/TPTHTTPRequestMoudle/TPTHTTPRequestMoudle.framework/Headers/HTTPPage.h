//
//  HTTPPage.h
//  HTTPRequest
//
//  Created by Napiac on 2022/7/19.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTTPPage : NSObject
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, readonly)NSInteger pagesize;

- (instancetype)initWithPage:(NSInteger)page pageSize:(NSInteger)pagesize;
///下一页
- (HTTPPage *)next;
///上一页
- (HTTPPage *)preVious;
///回到初始状态
- (HTTPPage *)reset;
///返回上一个状态
- (HTTPPage *)backState;
///构建接口分页参数
- (NSDictionary *)paramsBuild;

- (void)format:(HTTPPage *)page;
@end

NS_ASSUME_NONNULL_END
