//
//  TPTUIGeneralShareItem.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/13.
//

#import "TPTUIGeneralShareFormItem.h"

@implementation TPTUIGeneralShareFormItem


+ (instancetype)itemWithEnum:(ShareEnum)shareEnum {
    TPTUIGeneralShareFormItem * item = [[self alloc] init];
    item.shareEnum = shareEnum;
    return item;
}
@end
