//
//  MarketBaseView.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/27.
//

#import "CDMarketBaseView.h"

static CGFloat const sectionHeaderViewHeight = 45.0;
static CGFloat const nameTableViewWidth = 100.0;
static CGFloat const attributeUnitWidth = 100.0;

@interface CDMarketBaseView ()

@property (nonatomic, strong) UIScrollView *attributesScrollView;
@property (nonatomic, strong) CDNameBaseHeaderView *nameHeaderView;
@property (nonatomic, strong) CDAttributeBaseHeaderView *attributeHeaderView;

@end

@implementation CDMarketBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = [self getTitles];
        [self createViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat contentWidth = self.attributesScrollView.contentSize.width - nameTableViewWidth;
    CGFloat contentHeight = self.frame.size.height;
    
    self.nameHeaderView.frame = CGRectMake(0, 0, nameTableViewWidth, sectionHeaderViewHeight);
    self.attributeHeaderView.frame = CGRectMake(0, 0, contentWidth, sectionHeaderViewHeight);
    
    self.nameTableView.frame = CGRectMake(0, 0, nameTableViewWidth, contentHeight);
    self.attributesScrollView.frame = CGRectMake(0, 0, self.frame.size.width, contentHeight);
    self.attributesTableView.frame = CGRectMake(nameTableViewWidth, 0, contentWidth, contentHeight);
}

#pragma mark - setup UI
- (void)createViews {
    self.attributesScrollView = [[UIScrollView alloc] init];
    self.attributesScrollView.delegate = self;
    self.attributesScrollView.contentSize = CGSizeMake(attributeUnitWidth * self.titles.count + nameTableViewWidth, 0);
//    self.attributesScrollView.contentInset = UIEdgeInsetsMake(0, nameTableViewWidth, 0, 0);
    [self addSubview:self.attributesScrollView];
    
    self.attributesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.attributesTableView.dataSource = self;
    self.attributesTableView.delegate = self;
    self.attributesTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.attributesScrollView addSubview:self.attributesTableView];
    
    self.nameTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.nameTableView.dataSource = self;
    self.nameTableView.delegate = self;
    self.nameTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:self.nameTableView];
}

#pragma mark - getter
- (NSArray *)titles {
    if (!_titles) {
        _titles = [NSArray array];
    }
    return _titles;
}

#pragma mark - public
- (void)reloadData {
    [self.nameTableView reloadData];
    [self.attributesTableView reloadData];
}

#pragma mark - private
- (NSArray *)getTitles {
    NSArray *attributes = [AttributeHelper getHashAttributes];
    NSMutableArray *tmp = [NSMutableArray array];
    for (AttributeModel *model in attributes) {
        [tmp addObject:model.title];
    }
    return tmp.copy;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.delegate numberOfSectionsInMarketBaseView:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.delegate marketBaseView:self numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate marketBaseView:self tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(marketBaseView:didSelectRowAtIndexPath:)]) {
        [self.delegate marketBaseView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate marketBaseView:self heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(marketBaseView:viewForNameHeaderInSection:)] && [self.delegate respondsToSelector:@selector(marketBaseView:viewForAttributeHeaderInSection:)] && [self.delegate respondsToSelector:@selector(heightForHeaderWithMarketBaseView:)]) {
        return [self.delegate heightForHeaderWithMarketBaseView:self];
    }
    return sectionHeaderViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.nameTableView) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(marketBaseView:viewForNameHeaderInSection:)] && [self.delegate respondsToSelector:@selector(marketBaseView:viewForAttributeHeaderInSection:)] && [self.delegate respondsToSelector:@selector(heightForHeaderWithMarketBaseView:)]) {
            return [self.delegate marketBaseView:self viewForNameHeaderInSection:section];
        }else {
            if (self.nameHeaderView) {
                return self.nameHeaderView;
            }
            CDNameBaseHeaderView *nameHeaderView = [[CDNameBaseHeaderView alloc] initWithFrame:CGRectZero];
            nameHeaderView.delegate = self;
            self.nameHeaderView = nameHeaderView;
            return nameHeaderView;
        }
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(marketBaseView:viewForNameHeaderInSection:)] && [self.delegate respondsToSelector:@selector(marketBaseView:viewForAttributeHeaderInSection:)] && [self.delegate respondsToSelector:@selector(heightForHeaderWithMarketBaseView:)]) {
            return [self.delegate marketBaseView:self viewForAttributeHeaderInSection:section];
        }else {
            if (self.attributeHeaderView) {
                return self.attributeHeaderView;
            }
            CDAttributeBaseHeaderView *attributeHeaderView = [[CDAttributeBaseHeaderView alloc] initWithFrame:CGRectZero withTitles:self.titles];
            attributeHeaderView.delegate = self;
            self.attributeHeaderView = attributeHeaderView;
            return attributeHeaderView;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView class] == [UITableView class]) {
        //上下滑动tableView
        self.nameTableView.contentOffset = scrollView.contentOffset;
        self.attributesTableView.contentOffset = scrollView.contentOffset;
    }
}

#pragma mark - NameBaseHeaderViewDelegate
- (void)nameHeaderView:(CDNameBaseHeaderView *)headerView clickedEditButton:(UIButton *)editButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(marketBaseView:clickedEditButton:)]) {
        [self.delegate marketBaseView:self clickedEditButton:editButton];
    }
}

- (void)nameHeaderView:(CDNameBaseHeaderView *)headerView clickedCancelButton:(UIButton *)cancelButton {
    [self.attributeHeaderView cancelSort];
    if (self.delegate && [self.delegate respondsToSelector:@selector(marketBaseView:clickedCancelButton:)]) {
        [self.delegate marketBaseView:self clickedCancelButton:cancelButton];
    }
}

#pragma mark - AttributeBaseHeaderViewDelegate
- (void)attributeHeaderView:(CDAttributeBaseHeaderView *)headerView clickedButton:(UIButton *)button {
    self.nameHeaderView.editButton.hidden = YES;
    self.nameHeaderView.cancelButton.hidden = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(marketBaseView:clickedButton:)]) {
        [self.delegate marketBaseView:self clickedButton:button];
    }
}

@end
