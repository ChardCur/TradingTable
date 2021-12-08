//
//  TradingTableView.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/7.
//

#import "TradingTableView.h"
#import "TradingTableHeaderView.h"
#import "TradingTableViewCell.h"

static NSString *const cellIdentifier = @"ExcelTableViewCell";

@interface TradingTableView () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate>

@property (nonatomic, strong) TradingTableHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGPoint cacheContentOffset;

@end

@implementation TradingTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerView];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat headerHeight = [self.delegate tradingTableViewHeightForHeader];
    self.headerView.frame = CGRectMake(0, 0, self.frame.size.width, headerHeight);
    self.tableView.frame = CGRectMake(0, headerHeight, self.frame.size.width, self.frame.size.height - headerHeight);
}

- (void)reloadData {
    self.headerView.itemSize = [self.delegate tradingTableViewSizeForItem];
    self.headerView.dataArray = [self.delegate tradingTableViewTitlesOfColumns];
    [self.tableView reloadData];
}

#pragma mark - getter
- (TradingTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[TradingTableHeaderView alloc] initWithFrame:CGRectZero];
        _headerView.collectionView.delegate = self;
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor yellowColor];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.delegate tradingTableViewNumberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TradingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TradingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.itemSize = [self.delegate tradingTableViewSizeForItem];
    }
    cell.dataArray = [self.delegate tradingTableViewDataSource];
    cell.collectionView.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate tradingTableViewSizeForItem].height;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate tradingTableViewSizeForItem];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        if (scrollView.contentOffset.y != 0) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
        }
//        NSLog(@"scroll:%@ x: %f y: %f", [scrollView class], scrollView.contentOffset.x, scrollView.contentOffset.y);
//        NSLog(@"cacheoffset: %@", @(self.cacheContentOffset));

        self.headerView.collectionView.contentOffset = scrollView.contentOffset;

        for (TradingTableViewCell* cell in self.tableView.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = scrollView.contentOffset;
                    self.cacheContentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
                }
            }
        }

    }else {
//        NSLog(@"scroll:%@ x: %f y: %f", [scrollView class], scrollView.contentOffset.x, scrollView.contentOffset.y);
//        NSLog(@"cacheoffset: %@", @(self.cacheContentOffset));

        self.headerView.collectionView.contentOffset = self.cacheContentOffset;

        for (TradingTableViewCell* cell in self.tableView.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = self.cacheContentOffset;
                }
            }

        }
    }
}

@end
