//
//  RouterKitConst.h
//  RouterKit
//
//  Created by Napiac on 2023/2/21.
//

#ifndef RouterKitConst_h
#define RouterKitConst_h

/// 回调Block [handlerTag:回调标记 parameters:回调参数]
typedef void(^RouteKitCallbackBlock)(NSString * _Nullable handlerTag, __nullable id parameters);
/// 获取Block [handlerTag:回调标记 parameters:回调参数]
typedef id _Nullable(^RouteKitFetchBlock)(NSString * _Nullable handlerTag, __nullable id parameters);


#endif /* RouterKitConst_h */
