//
//  UICommonWebAnalysisManager.h
//  TPTAppIndependentMoudle
//
//  Created by 田建波 on 2022/9/20.
//

// 根据url解析结果自定义web样式
#import <Foundation/Foundation.h>
#import <TPTCoreMoudle/UICommonEaseOutModal.h>
#import "UICommonWebGeneralProtocol.h"

NS_ASSUME_NONNULL_BEGIN


@interface UICommonWebAnalysisManager : NSObject

@property(nonatomic, weak)id<UICommonWebGeneralProtocol> process;

@property(nonatomic, copy)NSString * webUrlString;

@end


NS_ASSUME_NONNULL_END
