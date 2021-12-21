//
//  MarketBaseContentViewController.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/20.
//

#import <UIKit/UIKit.h>
#import "TopTitleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MarketBaseContentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TopTitleViewDelegate>

@property (nonatomic, strong) TopTitleView *topTitleView;
@property (nonatomic, strong) UITableView *nameTableView;
@property (nonatomic, strong) UITableView *attributesTableView;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *titles;

@end

NS_ASSUME_NONNULL_END
