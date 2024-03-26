//
//  UIGeneralRewriteVAPWrapView.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/9.
//

#import "UIGeneralRewriteVAPWrapView.h"

@implementation UIGeneralRewriteVAPWrapView

- (NSString *)contentForVapTag:(NSString *)tag
                      resource:(QGVAPSourceInfo *)info {
    if (self.UIGeneralRewriteDelegate &&
        [self.UIGeneralRewriteDelegate respondsToSelector:@selector(rewriteVapWrapview_contentForVapTag:resource:view:)]) {
        return [self.UIGeneralRewriteDelegate rewriteVapWrapview_contentForVapTag:tag resource:info view:self];
    }
 
    return nil;
}

- (void)loadVapImageWithURL:(NSString *)urlStr
                    context:(NSDictionary *)context
                 completion:(VAPImageCompletionBlock)completionBlock {
    if (self.UIGeneralRewriteDelegate &&
        [self.UIGeneralRewriteDelegate respondsToSelector:@selector(rewriteVapWrapView_loadVapImageWithURL:context:view:completion:)]) {
        [self.UIGeneralRewriteDelegate rewriteVapWrapView_loadVapImageWithURL:urlStr context:context view:self completion:completionBlock];
    }
}


@end
