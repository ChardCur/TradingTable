//
//  MarketTestViewController.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/27.
//

#import "MarketTestViewController.h"
#import "CDMarketBaseView.h"
#import "AttributeCell.h"
#import "NameCell.h"

static CGFloat const tableViewCellRowHeight = 60.0;

@interface MarketTestViewController () <MarketBaseViewDelegate>


@property (nonatomic, copy) NSString *orderKey; //排序字段
@property (nonatomic, assign) BOOL isAscend;// 正序，降序

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *orderArray;

@property (nonatomic, strong) CDMarketBaseView *marketView;

@end

@implementation MarketTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.marketView = [[CDMarketBaseView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.marketView.delegate = self;
    [self.view addSubview:self.marketView];
    
    [self loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIEdgeInsets insets = self.view.safeAreaInsets;
    self.marketView.frame = CGRectMake(0, insets.top, self.view.frame.size.width, self.view.frame.size.height - insets.top - insets.bottom);
}

#pragma mark - getter
- (NSArray *)orderArray {
    if (!_orderArray) {
        _orderArray = [NSArray array];
    }
    return _orderArray;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

#pragma mark - data
- (void)loadData {
    // 请求自选股
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tmpData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *tmpArray = responseObject[@"rows"];
    
    // 保存请求数据
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dict in tmpArray) {
        StockModel *model = [[StockModel alloc] init];
        [model configWithDictionary:dict];
        [mutableArray addObject:model];
    }
    self.dataArray = mutableArray.copy;
    
    // 排序
    [self orderData];
}

- (void)orderData {
    if (kStringIsEmpty(self.orderKey)) {
        // 没有排序字段 按原数据顺序
        NSMutableArray *tmp = [NSMutableArray array];
        for (StockModel *model in self.dataArray) {
            [tmp addObject:model];
        }
        self.orderArray = tmp.copy;
    }else {
        // 有排序字段 冒泡排序
        self.orderArray = [self getOrderArrayWithArray:self.dataArray.mutableCopy OrderBy:self.orderKey IsAscend:self.isAscend];
    }
    
    [self.marketView reloadData];
}

#pragma mark - private
/**
 //冒泡排序
 @param  array    数据源数组
 @param  orderBy  按那个字段排序
 @param  isAscend 是否是升序
 @return 排好序的数组
 */
- (NSMutableArray *)getOrderArrayWithArray:(NSMutableArray *)array OrderBy:(NSString *)orderBy IsAscend:(BOOL)isAscend {
    if (isAscend) {
        //升序
        for (int i = 0; i < array.count - 1; i++) {
            for (int j = 0; j < array.count - i - 1; j++) {
                StockModel *fromModel = array[j];
                StockModel *toModel = array[j + 1];
                NSNumber *fromNum = [fromModel valueForKeyPath:orderBy];
                NSNumber *toNum = [toModel valueForKeyPath:orderBy];
                if ([fromNum floatValue] > [toNum floatValue]) {
                    StockModel *tempModel = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = tempModel;
                }
            }
        }
    }else {
        //倒序
        for (int i = 0; i < array.count - 1; i++) {
            for (int j = 0; j < array.count - i - 1; j++) {
                StockModel *fromModel = array[j];
                StockModel *toModel = array[j+1];
                //模型转字典
                NSNumber *fromNum = [fromModel valueForKeyPath:orderBy];
                NSNumber *toNum = [toModel valueForKeyPath:orderBy];
                if ([fromNum floatValue] < [toNum floatValue]) {
                    StockModel *tempModel = array[j];
                    array[j] = array[j+1];
                    array[j+1] = tempModel;
                }
            }
        }
    }
    return array;
}

#pragma mark - MarketBaseViewDelegate
- (NSInteger)numberOfSectionsInMarketBaseView:(CDMarketBaseView *)marketBaseView {
    return 1;
}

- (NSInteger)marketBaseView:(CDMarketBaseView *)marketBaseView numberOfRowsInSection:(NSInteger)section {
    return self.orderArray.count;
}

- (UITableViewCell *)marketBaseView:(CDMarketBaseView *)marketBaseView tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StockModel *model = [self.orderArray objectAtIndex:indexPath.row];
    if (tableView == marketBaseView.nameTableView) {
        NameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nameCellId"];
        if (!cell) {
            cell = [[NameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nameCellId"];
        }
        cell.model = model;
        return cell;
    }else {
        AttributeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"attributeCellId"];
        if (!cell) {
            cell = [[AttributeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"attributeCellId" withUnitCount:marketBaseView.titles.count];
        }
        cell.model = model;
        return cell;
    }
}

- (void)marketBaseView:(CDMarketBaseView *)marketBaseView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [marketBaseView.nameTableView deselectRowAtIndexPath:indexPath animated:YES];
    [marketBaseView.attributesTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)marketBaseView:(CDMarketBaseView *)marketBaseView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableViewCellRowHeight;
}

- (void)marketBaseView:(CDMarketBaseView *)marketBaseView clickedEditButton:(UIButton *)editButton {
    // route edit page
}

- (void)marketBaseView:(CDMarketBaseView *)marketBaseView clickedCancelButton:(UIButton *)cancelButton {
    self.orderKey = nil;
    [self orderData];
}

- (void)marketBaseView:(CDMarketBaseView *)marketBaseView clickedButton:(UIButton *)button {
    NSArray *tmp = [AttributeHelper getHashAttributes];
    AttributeModel *atrModel = [tmp objectAtIndex:(button.tag - 100)];
    self.orderKey = atrModel.keyName;
    self.isAscend = button.selected;
    [self orderData];
}

@end
