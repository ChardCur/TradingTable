//
//  TopTitleView.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/20.
//

#import "TopTitleView.h"

@interface TopTitleView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *lastSeletedButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation TopTitleView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        
        // 编辑按钮
        UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, editButtonWidth, frame.size.height)];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        editBtn.tag = 1000;
        editBtn.backgroundColor = [UIColor clearColor];
        [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [editBtn setImage:[UIImage imageNamed:@"Optional_edit"] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:editBtn];
        self.editButton = editBtn;
        
        // 取消按钮
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, editButtonWidth, frame.size.height)];
        [cancelBtn setTitle:@"取消排序" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        cancelBtn.tag = 1001;
        cancelBtn.backgroundColor = [UIColor clearColor];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setImage:[UIImage imageNamed:@"Optional_edit"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        cancelBtn.hidden = YES;
        [self addSubview:cancelBtn];
        self.cancelButton = cancelBtn;
        
        // scrollview
        self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(editButtonWidth, 0, frame.size.width - editButtonWidth, frame.size.height)];
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
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
            [_contentScrollView addSubview:btn];
        }
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _contentScrollView.frame = CGRectMake(editButtonWidth, 0, self.frame.size.width - editButtonWidth, self.frame.size.height);
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(topTitleView:scrollViewDidScroll:)]) {
        [self.delegate topTitleView:self scrollViewDidScroll:self.contentScrollView];
    }
}

#pragma mark - actions
- (void)editButtonClicked:(UIButton *)button {
    NSLog(@"edit");
    if (self.delegate && [self.delegate respondsToSelector:@selector(topTitleView:clickedEditButton:)]) {
        [self.delegate topTitleView:self clickedEditButton:button];
    }
}

- (void)cancelButtonClicked:(UIButton *)button {
    NSLog(@"cancel");
    button.hidden = YES;
    _editButton.hidden = NO;
    _lastSeletedButton.selected = NO;
    [_lastSeletedButton setImage:nil forState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(topTitleView:clickedCancelButton:)]) {
        [self.delegate topTitleView:self clickedCancelButton:button];
    }
}

- (void)clickedButton:(UIButton *)button {
    NSLog(@"atr button");
    [_lastSeletedButton setImage:nil forState:UIControlStateNormal];
    
    _editButton.hidden = YES;
    _cancelButton.hidden = NO;
    
    button.selected = !button.selected;
    NSString *imageString = button.selected ? @"optional_up" : @"optional_down";
    [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    _lastSeletedButton = button;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(topTitleView:clickedButton:)]) {
        [self.delegate topTitleView:self clickedButton:button];
    }
}

@end
