//
//  UIGeneralMoreActionModal.m
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/8/25.
//

#import "UIGeneralMoreActionAlert.h"
#import "UIGeneralMoreActionItemView.h"
#import "UIGeneralMoreActionSwitchCell.h"
#import "TPTUIGeneralMoudle.h"
#import <TPTCoreMoudle/UICommonEaseOutModal.h>
#import <TPTCoreMoudle/TPTCoreMoudle.h>

@interface UIGeneralMoreActionAlert ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
///标题label
@property(nonatomic, strong)UILabel *titleLabel;
///副标题label
@property(nonatomic, strong)UILabel *subTitleLabel;
///关闭按钮
@property(nonatomic, strong)UIButton *exitButton;
///总数据源
@property(nonatomic, strong)NSMutableArray<UIGeneralMoreActionItemModel *> *dataList;

///collection数据源
@property(nonatomic, strong)NSMutableArray<UIGeneralMoreActionItemModel *> *collectionDataList;
/// 宫格样式
@property(nonatomic, strong)UICollectionView *collectionView;

/// 列表样式
@property(nonatomic, strong)UITableView *tableView;
///table数据源
@property(nonatomic, strong)NSMutableArray<UIGeneralMoreActionItemModel *> *tableDataList;

@property(nonatomic, weak)UIView * inView;
@property(nonatomic, weak)UICommonEaseOutModal * inModal;

@end


@implementation UIGeneralMoreActionAlert

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self onContentLayout];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        items:(NSArray <UIGeneralMoreActionItemModel *>*)items;{
    self = [super init];
    if (self) {
        self.titleLabel.text = title;
        self.subTitleLabel.text = subTitle;
        [self.dataList addObjectsFromArray:items];
        [items enumerateObjectsUsingBlock:^(UIGeneralMoreActionItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj.isSwitchStyle){
                [self.tableDataList addObject:obj];
            }else{
                [self.collectionDataList addObject:obj];
            }
        }];
        [self.collectionView reloadData];
        [self.tableView reloadData];
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@85);
            make.left.right.equalTo(@0);
            make.height.equalTo(@([self collectionSize].height));
        }];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(([self collectionDataList].count>0)?self.collectionView.mas_bottom:@(75));
            make.height.equalTo(@([self tableSize].height));
        }];
    }
    return self;
}

- (void)showInView:(UIView *)view{
    UICommonEaseOutModal * modal = [UICommonEaseOutModal easeOut];
    [modal.contentView addSubview:self];
    modal.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    modal.contentView.frame = CGRectMake(0.f, kScreenH, kScreenW, [self contentSize].height);
    modal.contentView.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, kScreenW, [self contentSize].height);
    self.inView = view;
    self.inModal = modal;
    if (!view) {
        [modal showFrom:UICommonModalFromTop];
        return;
    }
    [modal showFrom:UICommonModalFromTop inAddView:view];
}

- (void)dismiss{
    if (self.inModal) {
        [self.inModal dismiss];
        return;
    }
    [[UICommonEaseOutModal fetchEaseOutModalInAddView:self.inView] dismiss];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self setRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight
                     radius:10];
}


#pragma mark -
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIGeneralMoreActionSwitchCell *itemView = [UIGeneralMoreActionSwitchCell loadCellWithTableView:tableView];
    UIGeneralMoreActionItemModel *model = [self.tableDataList objectAtIndex:indexPath.item];
    itemView.titleLabel.text = model.title;
    [itemView.switchButton setOn:model.switchIsOn];
    @weakify(model);
    @weakify(itemView);
    [[RACObserve(model, switchIsOn) takeUntil:itemView.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(itemView);
        @strongify(model);
        [itemView.switchButton setOn:model.switchIsOn];
    }];
    [[[itemView.switchButton rac_signalForControlEvents:UIControlEventValueChanged] takeUntil:itemView.rac_prepareForReuseSignal] subscribeNext:^(__kindof UISwitch * _Nullable x) {
        @strongify(model);
        model.switchIsOn = x.isOn;
        model.eventHander?model.eventHander(model):nil;
    }];
    return itemView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - UICollectionViewDataSource\UICollectionViewDelegate
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDataList.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIGeneralMoreActionItemView *itemView = [UIGeneralMoreActionItemView loadItemWithCollectionView:collectionView indexPath:indexPath];
    UIGeneralMoreActionItemModel *model = [self.collectionDataList objectAtIndex:indexPath.item];
    itemView.iconImageView.image = model.iconImage;
    itemView.titleLabel.text = model.title;
    return itemView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UIGeneralMoreActionItemModel *model = [self.collectionDataList objectAtIndex:indexPath.item];
    model.eventHander?model.eventHander(model):nil;
    [self dismiss];
}



- (void)onContentLayout{
    self.backgroundColor = [UIColor colorWithHexString:@"#F3F3F4"];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.exitButton];
    [self addSubview:self.collectionView];
    [self addSubview:self.tableView];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@20);
        make.right.equalTo(@-60);
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
        make.right.equalTo(@-60);
    }];
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(@2);
        make.width.height.equalTo(@56);
    }];
}


- (CGSize)contentSize{
    return CGSizeMake(kScreenW, 85+kSafeAreaBottomHeight + [self tableSize].height + [self collectionSize].height +12);
}

- (CGSize)collectionSize{
    NSUInteger collectionline = (self.collectionDataList.count/4)+(self.collectionDataList.count%4==0?0:1);
    return CGSizeMake(kScreenW, collectionline*(self.itemSize.height+self.itemSpace));
}
- (CGSize)tableSize{
    NSInteger  tableline = self.tableDataList.count;
    return CGSizeMake(kScreenW, 60*tableline);
}

#pragma mark -
#pragma mark - Layinit
- (CGFloat)itemSpace{
    return 6.5;
}
- (CGSize)itemSize{
    return  CGSizeMake((kScreenW-self.itemSpace*3-24)/4.f, 80);
}

- (NSMutableArray<UIGeneralMoreActionItemModel *> *)collectionDataList{
    if(!_collectionDataList){
        _collectionDataList = @[].mutableCopy;
    }
    return _collectionDataList;
}

- (NSMutableArray<UIGeneralMoreActionItemModel *> *)tableDataList{
    if(!_tableDataList){
        _tableDataList = @[].mutableCopy;
    }
    return _tableDataList;
}

- (NSMutableArray<UIGeneralMoreActionItemModel *> *)dataList{
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = ({
            UITableView * tableView = [[UITableView alloc] initWithFrame:self.bounds
                                                                       style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.estimatedRowHeight = 0.0f;
            tableView.estimatedSectionHeaderHeight = 0.0f;
            tableView.estimatedSectionFooterHeight = 0.0f;
            tableView.sectionFooterHeight = 0.0f;
            tableView.clipsToBounds = YES;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            if (@available(iOS 15.0, *)) {
                tableView.sectionHeaderTopPadding = 0;
            }
            if (@available(iOS 11.0, *)) {
                tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
            tableView.contentInset = UIEdgeInsetsZero;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.showsVerticalScrollIndicator = NO;
            tableView.showsHorizontalScrollIndicator = NO;
            tableView;
        });
    }
    return _tableView;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemSpace = self.itemSpace;
        layout.itemSize = self.itemSize;
        layout.minimumLineSpacing = itemSpace;
        layout.minimumInteritemSpacing = itemSpace;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#F3F3F4"];
        _collectionView.scrollEnabled = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.clipsToBounds = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}
- (UIButton *)exitButton{
    if (!_exitButton) {
        _exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exitButton setImage:UIGeneralBusinessBundleLoadImage(@"icon_close")
                     forState:UIControlStateNormal];
        [_exitButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitButton;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#141416"];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
        _subTitleLabel.textColor = [UIColor colorWithHexString:@"#6F7076"];
        _subTitleLabel.backgroundColor = [UIColor clearColor];
    }
    return _subTitleLabel;;
}
@end
