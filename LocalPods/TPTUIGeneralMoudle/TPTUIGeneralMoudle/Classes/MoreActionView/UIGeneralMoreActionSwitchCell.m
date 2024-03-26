//
//  UIGeneralMoreActionSwitchCell.m
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/10/15.
//

#import "UIGeneralMoreActionSwitchCell.h"

@interface UIGeneralMoreActionSwitchCell ()


@property(nonatomic, strong)UIView *bView;
@end

@implementation UIGeneralMoreActionSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.bView];
        [self.bView addSubview:self.switchButton];
        [self.bView addSubview:self.titleLabel];
        [self.bView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@12);
            make.right.equalTo(@-12);
            make.top.equalTo(@10);
            make.bottom.equalTo(@0);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.centerY.equalTo(@0);
        }];
        [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-16);
            make.centerY.equalTo(@0);
        }];
    }
    return self;
}


#pragma mark -
#pragma mark Layzinit
- (UIView *)bView{
    if(!_bView){
        _bView = [[UIView alloc] init];
        _bView.backgroundColor = [UIColor whiteColor];
        [_bView cornerRadius:6];
    }
    return _bView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#141416"];
    }
    return _titleLabel;
}

- (UISwitch *)switchButton{
    if(!_switchButton){
        _switchButton = [[UISwitch alloc] init];
    }
    return _switchButton;
}

@end
