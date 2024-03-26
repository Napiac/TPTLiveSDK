//
//  NSObject+Toast.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/8/3.
//

#import <Foundation/Foundation.h>
typedef void (^DismissHandler) (BOOL didTap);

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Toast)
- (void)showToast:(NSString *)message;
- (void)showToast:(NSString *)message inView:(UIView *)view;



- (void)showDebugToast:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
