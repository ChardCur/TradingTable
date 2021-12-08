//
//  TradingTableHeaderView.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/7.
//

#import "TradingTableHeaderView.h"
#import "TradingTitleCollectionViewCell.h"

static NSString *const collectionCellId = @"collectionCellId";
static CGFloat const itemEdge = 0.0f;

@interface TradingTableHeaderView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) UIView *lineView;

@end

@implementation TradingTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.accessoryView = [[UIView alloc] init];
        self.accessoryView.backgroundColor = [UIColor blueColor];
        [self addSubview:self.accessoryView];
        
        [self addSubview:self.collectionView];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [self addSubview:line];
        self.lineView = line;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.accessoryView.frame = CGRectMake(0, 0, self.itemSize.width, self.itemSize.height);
    self.collectionView.frame = CGRectMake(self.itemSize.width, 0, self.frame.size.width - self.itemSize.width, self.itemSize.height);
    self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN);
        layout.minimumLineSpacing = itemEdge;
        layout.minimumInteritemSpacing = itemEdge;
        layout.sectionInset = UIEdgeInsetsMake(0, itemEdge, 0, itemEdge);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[TradingTitleCollectionViewCell class] forCellWithReuseIdentifier:collectionCellId];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - collection dataSource delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TradingTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    cell.titleLabel.text = [self.dataArray objectAtIndex:indexPath.item];
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return self.itemSize;
//}

@end
