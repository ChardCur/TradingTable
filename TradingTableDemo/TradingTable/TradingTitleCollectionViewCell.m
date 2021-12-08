//
//  TradingTitleCollectionViewCell.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/7.
//

#import "TradingTitleCollectionViewCell.h"

@implementation TradingTitleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

@end
