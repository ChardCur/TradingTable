//
//  MarketBaseContentViewController.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/20.
//

#import "MarketBaseContentViewController.h"

static CGFloat const topTitleViewHeight = 50.0;
static CGFloat const nameTableViewWidth = 100.0;
static CGFloat const attributeUnitWidth = 100.0;

@interface MarketBaseContentViewController ()

@property (nonatomic, strong) UIScrollView *attributesScrollView;

@end

@implementation MarketBaseContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    UIEdgeInsets insets = self.view.safeAreaInsets;
    CGFloat contentWidth = self.view.frame.size.width - nameTableViewWidth;
    CGFloat contentHeight = self.view.frame.size.height - topTitleViewHeight - insets.top - insets.bottom;
    
    self.topTitleView.frame = CGRectMake(0, insets.top, self.view.frame.size.width, topTitleViewHeight);
    self.nameTableView.frame = CGRectMake(0, topTitleViewHeight + insets.top, nameTableViewWidth, contentHeight);
    self.attributesScrollView.frame = CGRectMake(nameTableViewWidth, topTitleViewHeight + insets.top, contentWidth, contentHeight);
    self.attributesTableView.frame = CGRectMake(0, 0, self.attributesScrollView.contentSize.width, contentHeight);
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

#pragma mark - setup UI
- (void)createViews {
    self.topTitleView = [[TopTitleView alloc] initWithFrame:CGRectMake(0, self.view.safeAreaInsets.top, self.view.frame.size.width, topTitleViewHeight) withTitles:self.titles];
    self.topTitleView.delegate = self;
    self.topTitleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.topTitleView];
    
    self.nameTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.nameTableView.dataSource = self;
    self.nameTableView.delegate = self;
    self.nameTableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.nameTableView];
    
    self.attributesScrollView = [[UIScrollView alloc] init];
    self.attributesScrollView.delegate = self;
    self.attributesScrollView.contentSize = CGSizeMake(attributeUnitWidth * self.titles.count, 0);
    [self.view addSubview:self.attributesScrollView];
    
    self.attributesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.attributesTableView.dataSource = self;
    self.attributesTableView.delegate = self;
    self.attributesTableView.backgroundColor = [UIColor blueColor];
    [self.attributesScrollView addSubview:self.attributesTableView];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.attributesScrollView) {
        //左右滑动scrollView
        self.topTitleView.contentScrollView.contentOffset = scrollView.contentOffset;
    }else {
        //上下滑动tableView
        self.nameTableView.contentOffset = scrollView.contentOffset;
        self.attributesTableView.contentOffset = scrollView.contentOffset;
    }
}

#pragma mark - TopTitleViewDelegate
- (void)topTitleView:(TopTitleView *)topTitleView scrollViewDidScroll:(UIScrollView *)scrollView {
    self.attributesScrollView.contentOffset = scrollView.contentOffset;
}

@end
