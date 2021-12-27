//
//  MarketBaseView.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/27.
//

#import <UIKit/UIKit.h>
#import "MarketConst.h"

@class CDMarketBaseView;
NS_ASSUME_NONNULL_BEGIN

@protocol MarketBaseViewDelegate <NSObject>

- (NSInteger)numberOfSectionsInMarketBaseView:(CDMarketBaseView *)marketBaseView;
- (NSInteger)marketBaseView:(CDMarketBaseView *)marketBaseView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)marketBaseView:(CDMarketBaseView *)marketBaseView tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)marketBaseView:(CDMarketBaseView *)marketBaseView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)marketBaseView:(CDMarketBaseView *)marketBaseView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (UIView *)marketBaseView:(CDMarketBaseView *)marketBaseView viewForNameHeaderInSection:(NSInteger)section;
- (UIView *)marketBaseView:(CDMarketBaseView *)marketBaseView viewForAttributeHeaderInSection:(NSInteger)section;
- (CGFloat)heightForHeaderWithMarketBaseView:(CDMarketBaseView *)marketBaseView;
- (void)marketBaseView:(CDMarketBaseView *)marketBaseView clickedEditButton:(UIButton *)editButton;
- (void)marketBaseView:(CDMarketBaseView *)marketBaseView clickedCancelButton:(UIButton *)cancelButton;
- (void)marketBaseView:(CDMarketBaseView *)marketBaseView clickedButton:(UIButton *)button;

@end

@interface CDMarketBaseView : UIView <UITableViewDataSource, UITableViewDelegate, AttributeBaseHeaderViewDelegate, NameBaseHeaderViewDelegate>

@property (nonatomic, strong) UITableView *nameTableView;
@property (nonatomic, strong) UITableView *attributesTableView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<MarketBaseViewDelegate> delegate;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
