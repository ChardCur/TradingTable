//
//  NameCell.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/21.
//

#import "NameCell.h"

@interface NameCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *codeLabel;

@end

@implementation NameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *codeLabel = [[UILabel alloc] init];
        codeLabel.textColor = [UIColor lightGrayColor];
        codeLabel.font = [UIFont systemFontOfSize:12];
        codeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:codeLabel];
        self.codeLabel = codeLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0; i < self.contentView.subviews.count; i ++) {
        UILabel *label = (UILabel *)[self.contentView.subviews objectAtIndex:i];
        if (i == 0) {
            label.frame = CGRectMake(0, 0, self.contentView.frame.size.width - 10, 20);
            CGPoint center = self.contentView.center;
            center.y -= 10;
            label.center = center;
        }else {
            label.frame = CGRectMake(0, 0, self.contentView.frame.size.width - 10, 15);
            CGPoint center = self.contentView.center;
            center.y += 10;
            label.center = center;
        }
    }
}

- (void)setModel:(StockModel *)model {
    _model = model;
    self.titleLabel.text = [model.Name substringFromIndex:1];
    self.codeLabel.text = model.Label;
}

@end
