//
//  TradingTableView.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/7.
//

#import <UIKit/UIKit.h>

@class TradingTableView;
NS_ASSUME_NONNULL_BEGIN

@protocol TradingTableViewDelegate <NSObject>

@required
- (NSInteger)tradingTableViewNumberOfRows;
- (NSArray *)tradingTableViewDataSource;
- (NSArray *)tradingTableViewTitlesOfColumns;

@optional
- (CGSize)tradingTableViewSizeForItem;
- (CGFloat)tradingTableViewHeightForHeader;

@end

@interface TradingTableView : UIView

@property (nonatomic, weak) id<TradingTableViewDelegate> delegate;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
