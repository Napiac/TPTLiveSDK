//
//  HTTPMacro.h
//  HTTPRequest
//
//  Created by Napiac on 2022/7/19.
//  Copyright © 2022 Napiac. All rights reserved.
//

#ifndef HTTPMacro_h
#define HTTPMacro_h

///通用的错误Code
static NSInteger const kResponse_Network_Error_Code = -1010;
///网络不可用Code
static NSInteger const kResponse_Network_NotAvailable_Code = -1011;
///网络请求错误Code
static NSInteger const kResponse_Reqeust_Error_Code = -1012;

///网络不可用Message
static NSString * const kResponse_Network_NotAvailable_Message = @"当前网络不可用，请检查";
#endif /* HTTPMacro_h */
