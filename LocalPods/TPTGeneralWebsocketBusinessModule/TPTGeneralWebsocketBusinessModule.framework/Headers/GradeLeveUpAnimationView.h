//
//  GradeLeveUpAnimationView.h
//  TPTGeneralWebsocketBusinessModule
//
//  Created by wangyin on 2023/4/27.
//


#import <TPTCoreMoudle/UICommonView.h>



NS_ASSUME_NONNULL_BEGIN

//等级提升动画类型
typedef NS_ENUM(NSUInteger, GradeLeveUpAnimationType) {
    GradeLeveUpAnimationType_Active = 0,//活跃等级提升动画
    GradeLeveUpAnimationType_Wealth,//财富等级提升动画
};

/**升级动画view*/
@interface GradeLeveUpAnimationView : UICommonView

+ (void)playAnimationWithType:(GradeLeveUpAnimationType)type
                  avatarImage:(NSURL *)url
                         name:(NSString *)name
                         text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
