//
//  TradingTableHeaderView.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TradingTableHeaderView : UIView

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *accessoryView;

@end

NS_ASSUME_NONNULL_END
