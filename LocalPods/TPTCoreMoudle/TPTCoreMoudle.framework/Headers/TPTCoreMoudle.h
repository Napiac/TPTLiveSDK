//
//  TPTCoreMoudle.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/29.
//

#ifndef TPTCoreMoudle_h
#define TPTCoreMoudle_h

#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <SDWebImage/UIImageView+WebCache.h>


#import "TPTCoreMoudleMacro.h"

#import "NSString+String.h"

#import "UIImage+Image.h"
#import "UIColor+Color.h"

#import "UIView+View.h"
#import "UIView+Frame.h"
#import "UIView+DisplayNetworkError.h"

#import "NSObject+Toast.h"
#import "NSObject+Object.h"
#import "NSObject+AppInfo.h"
#import "NSObject+Reflection.h"

#import "InitializationProtocol.h"
#import "UIConfigureProtocol.h"

#import "UICommonViewController.h"
#import "UICommonCollectionItem.h"
#import "UICommonTableCell.h"

NS_INLINE UIImage * _Nullable CoreBundleLoadImage(NSString * _Nullable imageName) {
    return LoadImage(imageName, kCoreImagesBundleName, NSStringFromClass([UICommonViewController class]));
}


#endif 
