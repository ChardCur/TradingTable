//
//  AttributeBaseHeaderView.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/27.
//

#import <UIKit/UIKit.h>
#import "MarketConst.h"

@class CDAttributeBaseHeaderView;
NS_ASSUME_NONNULL_BEGIN

@protocol AttributeBaseHeaderViewDelegate <NSObject>

- (void)attributeHeaderView:(CDAttributeBaseHeaderView *)headerView clickedButton:(UIButton *)button;

@end

@interface CDAttributeBaseHeaderView : UIView

@property (nonatomic, weak) id<AttributeBaseHeaderViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles;
- (void)cancelSort;

@end

NS_ASSUME_NONNULL_END
