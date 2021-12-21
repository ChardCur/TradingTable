//
//  NameCell.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/21.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NameCell : UITableViewCell

@property (nonatomic, strong) StockModel *model;

@end

NS_ASSUME_NONNULL_END
