//
//  AttributeHelper.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/21.
//

#import "AttributeHelper.h"

#define normalColor [UIColor blackColor]
#define increaseColor [UIColor redColor]
#define decreaseColor [UIColor greenColor]

@implementation AttributeHelper

+ (NSString *)floatStringWithNumber:(NSNumber *)num {
    return [NSString stringWithFormat:@"%.2f",num.floatValue];
}

+ (UIColor *)colorWithFloatValue:(float)value {
    if (value > 0) {
        return increaseColor;
    }else if (value < 0) {
        return decreaseColor;
    }else {
        return normalColor;
    }
}

+ (NSArray *)getHashAttributes {
    NSMutableArray *tmp = [NSMutableArray array];
    
    AttributeModel *newPriceModel = [[AttributeModel alloc] init];
    newPriceModel.title = @"最新";
    newPriceModel.keyName = @"NewPrice";
    [tmp addObject:newPriceModel];
    
    AttributeModel *gainsModel = [[AttributeModel alloc] init];
    gainsModel.title = @"涨幅";
    gainsModel.keyName = @"Gains";
    [tmp addObject:gainsModel];
    
    AttributeModel *riseFallModel = [[AttributeModel alloc] init];
    riseFallModel.title = @"涨跌";
    riseFallModel.keyName = @"RiseFall";
    [tmp addObject:riseFallModel];
    
    AttributeModel *higherSpeedModel = [[AttributeModel alloc] init];
    higherSpeedModel.title = @"涨速";
    higherSpeedModel.keyName = @"HigherSpeed";
    [tmp addObject:higherSpeedModel];
    
    AttributeModel *handModel = [[AttributeModel alloc] init];
    handModel.title = @"总手";
    handModel.keyName = @"Hand";
    [tmp addObject:handModel];
    
    AttributeModel *volumeRatioModel = [[AttributeModel alloc] init];
    volumeRatioModel.title = @"量比";
    volumeRatioModel.keyName = @"VolumeRatio";
    [tmp addObject:volumeRatioModel];
    
    AttributeModel *openModel = [[AttributeModel alloc] init];
    openModel.title = @"开盘";
    openModel.keyName = @"Open";
    [tmp addObject:openModel];
    
    AttributeModel *lastCloseModel = [[AttributeModel alloc] init];
    lastCloseModel.title = @"昨收";
    lastCloseModel.keyName = @"LastClose";
    [tmp addObject:lastCloseModel];
    
    AttributeModel *highModel = [[AttributeModel alloc] init];
    highModel.title = @"最高";
    highModel.keyName = @"High";
    [tmp addObject:highModel];
    
    AttributeModel *lowModel = [[AttributeModel alloc] init];
    lowModel.title = @"最低";
    lowModel.keyName = @"Low";
    [tmp addObject:lowModel];
    
    AttributeModel *appointThanModel = [[AttributeModel alloc] init];
    appointThanModel.title = @"委比";
    appointThanModel.keyName = @"AppointThan";
    [tmp addObject:appointThanModel];
    
    AttributeModel *swingModel = [[AttributeModel alloc] init];
    swingModel.title = @"振幅";
    swingModel.keyName = @"Swing";
    [tmp addObject:swingModel];
    
    return tmp.copy;
}

@end
