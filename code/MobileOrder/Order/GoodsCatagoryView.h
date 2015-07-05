//
//  GoodCatogoryTableViewController.h
//  MobileOrder
//
//  Created by cszhan on 15-5-30.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GooodsCatagoryDeleagte <NSObject>

@optional

- (void)didSelectorItemIndex:(NSInteger)index;

@end

@interface GoodsCatagoryView : UIView


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) id<GooodsCatagoryDeleagte> delegate;

- (id)initWithFrame:(CGRect)frame ;

@property (nonatomic,strong)NSArray *dataArray;

- (void)scrollViewToIndex:(NSInteger)index;

- (void)setNeedsLayout;

+ (CGFloat) getCatagoryCellHeight:(NSString*)txt ;

@end
