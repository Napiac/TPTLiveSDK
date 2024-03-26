//
//  UIGeneralWebStyleModal.m
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/21.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import "UIGeneralWebStyleModal.h"
#import <TPTCoreMoudle/UICommonWebView.h>
#import <TPTCoreMoudle/InitializationProtocol.h>
#import <TPTCoreMoudle/TPTCoreMoudleMacro.h>


@interface UIGeneralWebStyleModal ()<InitializationProtocol>
@property(nonatomic, strong)UICommonWebView * webView;
@end

@implementation UIGeneralWebStyleModal

- (instancetype)initWithURLString:(NSString *)URLString {
    if (URLString.length == 0) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (CGSize)contentSize {
    return self.bounds.size;
}


@end
