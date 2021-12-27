//
//  NameBaseHeaderView.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/27.
//

#import <UIKit/UIKit.h>
#import "MarketConst.h"

@class CDNameBaseHeaderView;
NS_ASSUME_NONNULL_BEGIN

@protocol NameBaseHeaderViewDelegate <NSObject>

@optional
- (void)nameHeaderView:(CDNameBaseHeaderView *)headerView clickedEditButton:(UIButton *)editButton;
- (void)nameHeaderView:(CDNameBaseHeaderView *)headerView clickedCancelButton:(UIButton *)cancelButton;

@end

@interface CDNameBaseHeaderView : UIView

@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, weak) id<NameBaseHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
