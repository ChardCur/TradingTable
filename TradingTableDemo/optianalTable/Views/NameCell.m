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
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.contentView.frame.size.width - 10, 20)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, self.contentView.frame.size.width - 10, 15)];
        codeLabel.textColor = [UIColor lightGrayColor];
        codeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:codeLabel];
        self.codeLabel = codeLabel;
    }
    return self;
}

- (void)setModel:(StockModel *)model {
    _model = model;
    self.titleLabel.text = [model.Name substringFromIndex:1];
    self.codeLabel.text = model.Label;
}

@end
