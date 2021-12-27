//
//  MarketConst.h
//  TradingTableDemo
//
//  Created by hlzq on 2021/12/21.
//

#ifndef MarketConst_h
#define MarketConst_h

#import "AttributeHelper.h"
#import "StockModel.h"
#import "CDAttributeBaseHeaderView.h"
#import "CDNameBaseHeaderView.h"

//判断数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//判断字符串书法为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

static CGFloat const editButtonWidth = 100;
static CGFloat const unitViewWidth = 100;

#endif /* MarketConst_h */
