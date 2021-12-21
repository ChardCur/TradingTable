//
//  StockModel.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StockModel : NSObject

@property (nonatomic, copy) NSString *Name;        //股票名称
@property (nonatomic, copy) NSString *Label;       //股票代码
@property (nonatomic, copy) NSNumber *NewPrice;    //最新价
@property (nonatomic, copy) NSNumber *Gains;       //涨幅
@property (nonatomic, copy) NSNumber *RiseFall;    //涨跌
@property (nonatomic, copy) NSNumber *HigherSpeed; //涨速
@property (nonatomic, copy) NSNumber *Hand;        //总手
@property (nonatomic, copy) NSNumber *VolumeRatio; //量比
@property (nonatomic, copy) NSNumber *Open;        //开盘价
@property (nonatomic, copy) NSNumber *LastClose;   //昨收
@property (nonatomic, copy) NSNumber *High;        //最高
@property (nonatomic, copy) NSNumber *Low;         //最低
@property (nonatomic, copy) NSNumber *AppointThan; //委比
@property (nonatomic, copy) NSNumber *Swing;       //振幅

- (void)configWithDictionary:(NSDictionary *)dictionary;

@end

@interface AttributeModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *keyName;

@end

NS_ASSUME_NONNULL_END
