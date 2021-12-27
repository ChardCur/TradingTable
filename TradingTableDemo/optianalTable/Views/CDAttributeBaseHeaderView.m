//
//  AttributeBaseHeaderView.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/27.
//

#import "CDAttributeBaseHeaderView.h"

@interface CDAttributeBaseHeaderView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *lastSeletedButton;

@end

@implementation CDAttributeBaseHeaderView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:144/255.0 alpha:0.2];
        
        // title buttons
        for (int i = 0; i < titles.count; i ++) {
            CGFloat btnX = unitViewWidth * i;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, unitViewWidth, frame.size.height)];
            btn.backgroundColor = [UIColor redColor];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.tag = 100 + i;
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIButton *btn in self.subviews) {
        CGRect frame = btn.frame;
        frame.size = CGSizeMake(unitViewWidth, self.frame.size.height);
        btn.frame = frame;
    }
}

- (void)cancelSort {
    _lastSeletedButton.selected = NO;
    [_lastSeletedButton setImage:nil forState:UIControlStateNormal];
}

#pragma mark - actions
- (void)clickedButton:(UIButton *)button {
    NSLog(@"atr button");
    if (_lastSeletedButton != button) {
        _lastSeletedButton.selected = NO;
        [_lastSeletedButton setImage:nil forState:UIControlStateNormal];
    }
    
    button.selected = !button.selected;
    NSString *imageString = button.selected ? @"optional_up" : @"optional_down";
    [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    _lastSeletedButton = button;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(attributeHeaderView:clickedButton:)]) {
        [self.delegate attributeHeaderView:self clickedButton:button];
    }
}

@end
