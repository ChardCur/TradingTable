//
//  AttributeCell.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/21.
//

#import "AttributeCell.h"
#import "MarketConst.h"
#import <objc/runtime.h>

@interface AttributeCell ()

@property (nonatomic, assign) NSInteger labelCount;

@end

@implementation AttributeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withUnitCount:(NSInteger)unitCount {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置UI
        [self setUIWithUnitCount:unitCount];
    }
    return self;
}

- (void)setUIWithUnitCount:(NSInteger)count {
    _labelCount = count;
    for (int i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(unitViewWidth * i, 0, unitViewWidth, self.contentView.frame.size.height)];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"--";
        label.tag = 100 + i;
        [self.contentView addSubview:label];
    }
}

- (void)setModel:(StockModel *)model {
    _model = model;
    NSArray *attributes = [AttributeHelper getHashAttributes];
    for (int i = 0; i < attributes.count; i ++) {
        AttributeModel *atrModel = attributes[i];
        
        UILabel *label = [self viewWithTag:100 + i];
        NSNumber *num = [model valueForKeyPath:atrModel.keyName];
        label.text = [AttributeHelper floatStringWithNumber:num];
        label.textColor = [AttributeHelper colorWithFloatValue:num.floatValue];
    }
}

@end
