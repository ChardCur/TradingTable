//
//  StockModel.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/20.
//

#import "StockModel.h"

@implementation StockModel

- (void)configWithDictionary:(NSDictionary *)dictionary {
    self.Name = [dictionary objectForKey:@"Name"];
    self.Label = [dictionary objectForKey:@"Label"];
    self.NewPrice = [dictionary objectForKey:@"NewPrice"];
    self.Gains = [dictionary objectForKey:@"Gains"];
    self.RiseFall = [dictionary objectForKey:@"RiseFall"];
    self.HigherSpeed = [dictionary objectForKey:@"HigherSpeed"];
    self.Hand = [dictionary objectForKey:@"Hand"];
    self.VolumeRatio = [dictionary objectForKey:@"VolumeRatio"];
    self.Open = [dictionary objectForKey:@"Open"];
    self.LastClose = [dictionary objectForKey:@"LastClose"];
    self.High = [dictionary objectForKey:@"High"];
    self.Low = [dictionary objectForKey:@"Low"];
    self.AppointThan = [dictionary objectForKey:@"AppointThan"];
    self.Swing = [dictionary objectForKey:@"Swing"];
}

@end

@implementation AttributeModel

@end
