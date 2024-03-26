//
//  FlowTRTCConnectListenerWrapper.h
//  TPTFlowObjectMoulde
//
//  Created by Napiac on 2022/10/19.
//

#import <Foundation/Foundation.h>
#import <TXLiteAVSDK_Professional/TRTCCloudDelegate.h>

@class RACSignal;
@class RACDisposable;
NS_ASSUME_NONNULL_BEGIN

@interface FlowTRTCConnectListenerWrapper : NSObject<TRTCCloudDelegate>

@property(nonatomic, strong)RACDisposable * inRoomUsersVolumeDisposable;

- (RACSignal *)errorSignal;
- (RACSignal *)enterRoomSignal;
- (RACSignal *)exitRoomSignal;
- (RACSignal *)inRoomUsersVoiceVolumeSignal;


@end

NS_ASSUME_NONNULL_END
