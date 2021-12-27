//
//  NameBaseHeaderView.m
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/27.
//

#import "CDNameBaseHeaderView.h"

@interface CDNameBaseHeaderView ()

@end

@implementation CDNameBaseHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:144/255.0 alpha:0.2];
        
        // 编辑按钮
        UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, editButtonWidth, frame.size.height)];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        editBtn.tag = 1000;
        editBtn.backgroundColor = [UIColor clearColor];
        [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [editBtn setImage:[UIImage imageNamed:@"optional_edit"] forState:UIControlStateNormal];
        editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
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
        [cancelBtn addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        cancelBtn.hidden = YES;
        [self addSubview:cancelBtn];
        self.cancelButton = cancelBtn;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.editButton.frame = CGRectMake(0, 0, editButtonWidth, self.frame.size.height);
    self.cancelButton.frame = CGRectMake(0, 0, editButtonWidth, self.frame.size.height);
}

#pragma mark - actions
- (void)editButtonClicked:(UIButton *)button {
    NSLog(@"edit");
    if (self.delegate && [self.delegate respondsToSelector:@selector(nameHeaderView:clickedEditButton:)]) {
        [self.delegate nameHeaderView:self clickedEditButton:button];
    }
}

- (void)cancelButtonClicked:(UIButton *)button {
    NSLog(@"cancel");
    button.hidden = YES;
    _editButton.hidden = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(nameHeaderView:clickedCancelButton:)]) {
        [self.delegate nameHeaderView:self clickedCancelButton:button];
    }
}

@end
