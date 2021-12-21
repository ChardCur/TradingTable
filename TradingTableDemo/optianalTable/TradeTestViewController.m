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

@interface TradeTestViewController ()

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
    [self.nameTableView reloadData];
    [self.attributesTableView reloadData];
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StockModel *model = [self.dataArray objectAtIndex:indexPath.row];
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

@end
