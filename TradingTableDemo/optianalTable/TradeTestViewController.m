//
//  TradeTestViewController.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/20.
//

#import "TradeTestViewController.h"
#import "StockModel.h"
#import "AttributeCell.h"
#import "NameCell.h"
#import "MarketConst.h"

static CGFloat const tableViewCellRowHeight = 70.0;

@interface TradeTestViewController ()

@property (nonatomic, copy) NSString *orderKey; //排序字段
@property (nonatomic, assign) BOOL isAscend;// 正序，降序
@property (nonatomic, strong) NSArray *orderArray;

@end

@implementation TradeTestViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titles = @[@"最新",@"涨幅",@"涨跌",@"涨速",@"总手",@"量比",@"开盘",@"昨收",@"最高",@"最低",@"委比",@"振幅"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

#pragma mark - private
- (void)loadData {
    // 请求自选股
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tmpData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *tmpArray = responseObject[@"rows"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dict in tmpArray) {
        StockModel *model = [[StockModel alloc] init];
        [model configWithDictionary:dict];
        [mutableArray addObject:model];
    }
    self.dataArray = mutableArray.copy;
    
    if (kStringIsEmpty(self.orderKey)) {
        self.orderArray = mutableArray.copy;
    }else {
        self.orderArray = [self getOrderArrayWithArray:mutableArray OrderBy:self.orderKey IsAscend:self.isAscend];
    }
    
    [self.nameTableView reloadData];
    [self.attributesTableView reloadData];
}

- (void)orderData {
    if (kStringIsEmpty(self.orderKey)) {
        NSMutableArray *tmp = [NSMutableArray array];
        for (StockModel *model in self.dataArray) {
            [tmp addObject:model];
        }
        self.orderArray = tmp.copy;
    }else {
        self.orderArray = [self getOrderArrayWithArray:self.dataArray.mutableCopy OrderBy:self.orderKey IsAscend:self.isAscend];
    }
    
    [self.nameTableView reloadData];
    [self.attributesTableView reloadData];
}

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

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StockModel *model = [self.orderArray objectAtIndex:indexPath.row];
    if (tableView == self.nameTableView) {
        NameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nameCellId"];
        if (!cell) {
            cell = [[NameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nameCellId"];
        }
        cell.model = model;
        return cell;
    }else {
        AttributeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"attributeCellId"];
        if (!cell) {
            cell = [[AttributeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"attributeCellId" withUnitCount:self.titles.count];
        }
        cell.model = model;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableViewCellRowHeight;
}

#pragma mark - topTitleView delegate
- (void)topTitleView:(TopTitleView *)topTitleView clickedEditButton:(UIButton *)editButton {
    // do something
}

- (void)topTitleView:(TopTitleView *)topTitleView clickedCancelButton:(UIButton *)cancelButton {
    self.orderKey = nil;
    [self orderData];
}

- (void)topTitleView:(TopTitleView *)topTitleView clickedButton:(UIButton *)button {
    NSArray *tmp = [AttributeHelper getHashAttributes];
    AttributeModel *atrModel = [tmp objectAtIndex:(button.tag - 100)];
    self.orderKey = atrModel.keyName;
    self.isAscend = button.selected;
    [self orderData];
}

@end
