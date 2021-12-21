//
//  AttributeCell.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/21.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttributeCell : UITableViewCell

@property (nonatomic, strong) StockModel *model;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withUnitCount:(NSInteger)unitCount;

@end

NS_ASSUME_NONNULL_END
