//
//  TopTitleView.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/20.
//

#import <UIKit/UIKit.h>
#import "MarketConst.h"

@class TopTitleView;
NS_ASSUME_NONNULL_BEGIN

@protocol TopTitleViewDelegate <NSObject>

@optional
- (void)topTitleView:(TopTitleView *)topTitleView scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)topTitleView:(TopTitleView *)topTitleView clickedEditButton:(UIButton *)editButton;
- (void)topTitleView:(TopTitleView *)topTitleView clickedCancelButton:(UIButton *)cancelButton;
- (void)topTitleView:(TopTitleView *)topTitleView clickedButton:(UIButton *)button;

@end

@interface TopTitleView : UIView

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, weak) id<TopTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles;

@end

NS_ASSUME_NONNULL_END
