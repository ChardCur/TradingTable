//
//  TradingCollectionViewCell.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/7.
//

#import "TradingCollectionViewCell.h"

@interface TradingCollectionViewCell ()

@end

@implementation TradingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

@end
