//
//  LiveBraceGiftRecordView.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by wansheng on 2022/10/13.
//  本场收礼记录view

#import <TPTCoreMoudle/UICommonView.h>
#import <TPTCoreMoudle/UICommonEaseOutModal.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceGiftRecordView : UICommonView

@end


@interface LiveBraceGiftRecordEaseOutModal : UICommonEaseOutModal
@property (nonatomic, strong) LiveBraceGiftRecordView *detailView;
- (void)showModalWithParams:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
