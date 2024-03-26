//
//  UIGeneralEmptyView.m
//  TPTUIGeneralMoudle
//
//  Created by 凡骄 on 2022/8/24.
//

#import "UIGeneralEmptyView.h"
#import <TPTCoreMoudle/TPTCoreMoudle.h>

@interface UIGeneralEmptyView ()

@property (nonatomic, strong) UIImageView * emptyImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIButton * refreshButton;

@end


@implementation UIGeneralEmptyView

- (void)initializationUserInterface {
    _includeSectionView = YES;
    _includeHeaderFooterView = YES;
    
    [self.contentView addSubview:self.emptyImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.refreshButton];
}

- (void)setupSubviews {
    [super setupSubviews];
    
    @weakify(self);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        if (self.customView) {
            make.size.mas_equalTo(self.customView.size);
        }
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    NSMutableArray *subViewsArray = @[].mutableCopy;
    if (self.image) {
        self.emptyImageView.image = self.image;
        @weakify(self);
        [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.size.mas_equalTo(self.image.size);
            make.top.mas_equalTo(4);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        [subViewsArray addObject:self.emptyImageView];
    }
    
    self.titleLabel.hidden = YES;
    if (self.titleString.length > 0) {
        self.titleLabel.hidden = NO;
        self.titleLabel.text = self.titleString;
        @weakify(self);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.mas_equalTo(self.emptyImageView.mas_bottom).offset(8.f);
            make.left.mas_equalTo(16.f);
            make.right.mas_equalTo(-16.f);
        }];
        [subViewsArray addObject:self.titleLabel];
    }
    
    self.contentLabel.hidden = YES;
    if (self.contentString.length > 0) {
        self.contentLabel.hidden = NO;
        self.contentLabel.text = self.contentString;
        CGFloat bottomOffset = 8.0;
        MASViewAttribute *bottom = self.emptyImageView.mas_bottom;
        if (self.titleString.length > 0) {
            bottom = self.titleLabel.mas_bottom;
            bottomOffset = 4.0;
        }
        @weakify(self);
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.mas_equalTo(bottom).offset(bottomOffset);
            make.left.mas_equalTo(16.f);
            make.right.mas_equalTo(-16.f);
        }];
        [subViewsArray addObject:self.contentLabel];
    }
    
    self.refreshButton.hidden = YES;
    if (self.refreshButtonTarget && self.refreshButtonTarget) {
        self.refreshButton.hidden = NO;
        [self.refreshButton addTarget:self.refreshButtonTarget action:self.refreshButtonAction forControlEvents:UIControlEventTouchUpInside];
        if (self.refreshButtonTitleString.length > 0) {
            [self.refreshButton setTitle:self.refreshButtonTitleString forState:UIControlStateNormal];
        }
        UIView *lastView = subViewsArray.lastObject;
        @weakify(self);
        [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.mas_equalTo(lastView.mas_bottom).offset(4.f);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.mas_equalTo(114.f);
            make.height.mas_equalTo(32.f);
            
        }];
        [subViewsArray addObject:self.refreshButton];
    }
    
    if (subViewsArray.count > 0) {
        UIView *lastView = subViewsArray.lastObject;
        [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-4.f);
        }];
    }
}


#pragma mark -> Private Methods
- (void)refreshEmptyImageViewFrame:(CGFloat)y {
    @weakify(self);
    [self.emptyImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(-y);
    }];
}


#pragma mark -> Setter/Getter
- (UIImageView *)emptyImageView {
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _emptyImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _emptyImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        _titleLabel.font = [UIFont systemFontOfSize:14.f weight:UIFontWeightBold];
        _titleLabel.textAlignment = 1;
        _titleLabel.hidden = YES;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _contentLabel.font = [UIFont systemFontOfSize:14.f];
        _contentLabel.textAlignment = 1;
        _contentLabel.hidden = YES;
    }
    return _contentLabel;
}

- (UIButton *)refreshButton {
    if (!_refreshButton) {
        _refreshButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_refreshButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_refreshButton.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
        _refreshButton.hidden = YES;
    }
    return _refreshButton;
}


@end
