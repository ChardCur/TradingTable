//
//  AttributeHelper.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/21.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttributeHelper : NSObject

+ (NSString *)floatStringWithNumber:(NSNumber *)num;
+ (UIColor *)colorWithFloatValue:(float)value;
+ (NSArray *)getProperties:(Class)cls;
+ (NSArray *)getHashAttributes;

@end

NS_ASSUME_NONNULL_END
