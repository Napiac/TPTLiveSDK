//
//  UIGeneralMoreActionItemView.m
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/8/25.
//

#import <TPTCoreMoudle/TPTCoreMoudle.h>
#import "UIGeneralMoreActionItemView.h"

@interface UIGeneralMoreActionItemView ()

@end

@implementation UIGeneralMoreActionItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
        [self cornerRadius:6];
    }
    return self;
}

- (void)setupSubViews{
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.centerX.equalTo(@0);
        make.width.height.equalTo(@34);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(7);
        make.centerX.equalTo(@0);
    }];
}





#pragma mark -
#pragma mark - Layinit
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#141416"];
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    return _iconImageView;
}
@end
