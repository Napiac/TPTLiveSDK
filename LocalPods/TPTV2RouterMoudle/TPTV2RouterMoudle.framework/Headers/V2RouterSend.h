//
//  V2RouterSend.h
//  TPTV2RouterMoudle
//
//  Created by Napiac on 2023/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 数据JSON操作
/// - Parameters:
///   - object: 数据
///   - type: 查看Core/Json
NSObject * _Nullable V2RouterSend_Json(id object, NSInteger type);


/// 获取应用程序的Window
UIView * _Nullable V2RouterSend_FetchApplicationWindow (void);


/// 显示Toast
/// - Parameter toast: 文字
void V2RouterSend_ShowToast(NSString * toast);

NS_ASSUME_NONNULL_END
