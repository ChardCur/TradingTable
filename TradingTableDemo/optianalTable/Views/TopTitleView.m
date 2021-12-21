//
//  TopTitleView.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/20.
//

#import "TopTitleView.h"

@interface TopTitleView () <UIScrollViewDelegate>

@end

@implementation TopTitleView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        
        // 编辑按钮
        UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, editButtonWidth, frame.size.height)];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        editBtn.tag = 1000;
        editBtn.backgroundColor = [UIColor orangeColor];
        [editBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [editBtn setImage:[UIImage imageNamed:@"Optional_edit"] forState:(UIControlStateNormal)];
        [editBtn addTarget:self action:@selector(editButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:editBtn];
        
        // scrollview
        self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(editButtonWidth, 0, frame.size.width - editButtonWidth, frame.size.height)];
        _contentScrollView.backgroundColor = [UIColor whiteColor];
        _contentScrollView.contentSize = CGSizeMake(unitViewWidth * titles.count, 0);
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.delegate = self;
        [self addSubview:_contentScrollView];
        
        // title buttons
        for (int i = 0; i < titles.count; i ++) {
            CGFloat btnX = unitViewWidth * i;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, unitViewWidth, frame.size.height)];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.tag = 100 + i;
            btn.backgroundColor = [UIColor cyanColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_contentScrollView addSubview:btn];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _contentScrollView.frame = CGRectMake(editButtonWidth, 0, self.frame.size.width - editButtonWidth, self.frame.size.height);
}

#pragma mark -- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(topTitleView:scrollViewDidScroll:)]) {
        [self.delegate topTitleView:self scrollViewDidScroll:self.contentScrollView];
    }
}

#pragma mark - actions
- (void)editButtonClicked:(UIButton *)button {
    NSLog(@"edit ");
}

@end
