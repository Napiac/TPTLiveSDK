//
//  TPTUIGeneralPhotoBrowserModal.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/13.
//

///照片浏览器Modal
#import <TPTCoreMoudle/UICommonEaseOutModal.h>
#import "TPTUIGeneralPhotoBrowser.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPTUIGeneralPhotoBrowserModal : UICommonEaseOutModal

@property(nonatomic, strong, readonly)TPTUIGeneralPhotoBrowser * photoBrowser;

+ (instancetype)modalWithPhotos:(NSArray <NSString *> *)photoURLPaths
                   currentIndex:(NSInteger)currentIndex;
@end

NS_ASSUME_NONNULL_END
