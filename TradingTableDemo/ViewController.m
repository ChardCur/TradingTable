//
//  ViewController.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/7.
//

#import "ViewController.h"
#import "TradingTableView.h"

@interface ViewController () <TradingTableViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    [self setupTableView];
    
}

#pragma mark - private
- (void)setupTableView {
    TradingTableView *tableView = [[TradingTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 34)];
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    [tableView reloadData];
}

- (void)loadData {
    self.titles = @[@"最新价格", @"涨幅", @"成交额", @"流通市值", @"成交量", @"换手", @"涨速"];
    self.dataArray = @[@"100", @"10%", @"6666", @"166", @"666600", @"17%", @"10.0"];
}

#pragma mark - getter
- (NSArray *)titles {
    if (!_titles) {
        _titles = [NSArray array];
    }
    return _titles;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

#pragma mark - TradingTableViewDelegate
- (NSInteger)tradingTableViewNumberOfRows {
    return 20;
}

- (NSArray *)tradingTableViewTitlesOfColumns {
    return self.titles;
}

- (NSArray *)tradingTableViewDataSource {
    return self.dataArray;
}

- (CGSize)tradingTableViewSizeForItem {
    return CGSizeMake(80, 50);
}

- (CGFloat)tradingTableViewHeightForHeader {
    return 45.0;
}

@end
