//
//  GeneralWsAlertModel.h
//  TPTGeneralWebsocketBusinessModule
//
//  Created by wangyin on 2023/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeneralWsAlertJumpAddress : NSObject
@property (nonatomic, copy)NSString *ios_url;
@end

@interface GeneralWsAlertJumpConfig : NSObject
@property (nonatomic, copy)NSString *open_type;
@property (nonatomic, strong)GeneralWsAlertJumpAddress *jump_address;
@end

@interface  GeneralWsAlertInfoModel: NSObject
@property (nonatomic, copy)NSString *pop_up_title;
@property (nonatomic, copy)NSString *pop_up_content;
@property (nonatomic, copy)NSString *pop_up_title_color;
@property (nonatomic, copy)NSString *pop_up_content_color;
@property (nonatomic, copy)NSString *background_color;
@property (nonatomic, copy)NSString *background_img;
@end

@interface  GeneralWsAlertButtonModel: NSObject
@property (nonatomic, copy)NSString *button_name;
@property (nonatomic, copy)NSString *button_name_color;
@property (nonatomic, strong)GeneralWsAlertJumpConfig *jump_config_info;
@end

@interface GeneralWsAlertModel : NSObject
@property (nonatomic, strong)GeneralWsAlertInfoModel *pop_up_info;
@property (nonatomic, strong)NSArray <GeneralWsAlertButtonModel *>*button_list;
@end

NS_ASSUME_NONNULL_END
