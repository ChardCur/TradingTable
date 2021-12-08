//
//  TradingTableViewCell.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/7.
//

#import "TradingTableViewCell.h"
#import "TradingCollectionViewCell.h"

static NSString *const tableCollectionCellId = @"tableCollectionCellId";
static CGFloat const itemEdge = 0.0f;

@interface TradingTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@end

@implementation TradingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftView = [[UIView alloc] init];
        self.leftView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.leftView];
        
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.leftView.frame = CGRectMake(0, 0, self.itemSize.width, self.itemSize.height);
    self.collectionView.frame = CGRectMake(self.itemSize.width, 0, self.frame.size.width - self.itemSize.width, self.itemSize.height);
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
        [_collectionView registerClass:[TradingCollectionViewCell class] forCellWithReuseIdentifier:tableCollectionCellId];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - collection dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TradingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tableCollectionCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    cell.titleLabel.text = [self.dataArray objectAtIndex:indexPath.item];
    return cell;
}

@end
