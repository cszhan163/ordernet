//
//  OrderMenuView.m
//  MobileOrder
//
//  Created by cszhan on 15-6-6.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "GoodsOrderMenuView.h"

#import "FoodMenuCell.h"

#import "GoodsCatagoryItem.h"


#define  kOrderMenuCellHeight      44.f


 static NSString *cellId = @"resumeMenuCellId";

@interface GoodsOrderMenuView(){

      CGRect targeFrame;
}
@end

@implementation GoodsOrderMenuView

- (void)dealloc {
    self.bgView = nil;
    SuperDealloc;
}


- (void)updateDataByOrderListArray:(NSArray*)data {

   
#if 1
   NSMutableArray *orderArray = [NSMutableArray array];
    for(GoodsCatagoryItem *item in data) {
        if([item.subCatogoryArray count]){
            NSString *foodName = item.name;
            for(SubCatagoryItem *subItem in item.subCatogoryArray) {
                GoodsOrderItem *goodOrderItem = [[GoodsOrderItem alloc]initWithGoodsName:foodName withCatagoryItem:subItem];
                [orderArray addObject:goodOrderItem];
                SafeRelease(goodOrderItem);
            }
        } else {
            //no sub kind
            GoodsOrderItem *goodOrderItem = [[GoodsOrderItem alloc]initWithGoodsName:@"" withCatagoryItem:item];
            [orderArray addObject:goodOrderItem];
            SafeRelease(goodOrderItem);
        }
    }
    self.dataArray = orderArray;
#else
    self.dataArray = data;
#endif
   
}

- (id)initWithFrame:(CGRect)frame  {

    if(self = [super initWithFrame:frame]) {
        
        //self.tableView.center = CGPointMake(frame.size.width/2.f, frame.size.height/2.f);
        [self.tableView registerClass:[FoodMenuCell class] forCellReuseIdentifier:cellId];
    }
    return self;
}

- (void)showInView:(UIView*)view  withOffsetY:(CGFloat)offsetY animated:(BOOL) animated {
    
    UIWindow *keyWnd= [[UIApplication sharedApplication]keyWindow];
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    _bgView = [[UIView alloc]initWithFrame:rect];
    _bgView.backgroundColor = HexRGBA(0, 0, 0, 0.7);
    [_bgView addSubview:self];
    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_bgView addGestureRecognizer:tapGuesture];
    
    SafeRelease(tapGuesture);
    
    [keyWnd addSubview:_bgView];
    
    NSInteger number= [self.dataArray count];
    CGSize size  = CGSizeMake(view.frame.size.width, (view.frame.size.height-offsetY)/2.f);
    if(number * kOrderMenuCellHeight >(self.frame.size.height-offsetY)/2.f){
        targeFrame= CGRectMake(0.f,(self.frame.size.height-offsetY)/2.f,size.width,size.height);
    } else {
        size.height = number*kOrderMenuCellHeight;
        targeFrame = CGRectMake(0.f,self.frame.size.height-size.height-offsetY,size.width, size.height);
    }
    //[view addSubview:_bgView];
    if(animated){
        _bgView.alpha = 0;
        self.tableView.frame = CGRectOffset(targeFrame, 0,targeFrame.size.height);
        [UIView animateWithDuration:.35 animations:^{
            _bgView.alpha = 1;
            self.tableView.frame = targeFrame;
        }];
    } else {
    
        _bgView.alpha = 0;
        self.tableView.frame = targeFrame;
    }
    [self.tableView reloadData];
}
- (void)disMiss:(BOOL)animated {
    
    if(animated){
        _bgView.alpha = 1;
        //self.tableView.frame = targeFrame;
        [UIView animateWithDuration:.35 animations:^{
            _bgView.alpha = 0;
            self.tableView.frame = CGRectOffset(targeFrame, 0,targeFrame.size.height);
        }];
    } else {
        
        _bgView.alpha = 0;
        self.tableView.frame = CGRectOffset(targeFrame, 0,targeFrame.size.height);
    }
}

- (void)tapAction:(id)sender {

    [self disMiss:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    GoodsCatagoryItem *item = [self.dataArray objectAtIndex:indexPath.row];
    return item.cellHeight;
    */
    return kOrderMenuCellHeight;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if(cell == nil){
        
        cell = [[FoodMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
#if 1
    GoodsOrderItem *item = [self.dataArray objectAtIndex:indexPath.row];
    //cell.titleLable.text =  [NSString stringWithFormat:@"%@+%@",item.goodsName,item.name];
    [cell setFoodName:item.goodsName];
    [cell setCellItem:item.subCatagoryItem];
    [cell setDelegate:self];
#else
    cell.titleLable.text =  [self.dataArray objectAtIndex:indexPath.row];
#endif
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectorItemIndex:)]) {
        
        [self.delegate didSelectorItemIndex:indexPath.row];
    }
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
    
    
}




@end
