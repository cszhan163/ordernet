//
//  OrderMenuView.m
//  MobileOrder
//
//  Created by cszhan on 15-6-6.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "GoodsOrderMenuView.h"

#import "FoodSubItemCell.h"

#import "GoodsCatagoryItem.h"


 static NSString *cellId = @"resumeFoodCellId";

@implementation GoodsOrderMenuView


- (void)updateDataByOrderListArray:(NSArray*)data {

    NSMutableArray *orderArray = [NSMutableArray array];
    for(GoodsCatagoryItem *item in data) {
        NSString *foodName = item.name;
        for(SubCatagoryItem *subItem in item.subCatogoryArray) {
            GoodsOrderItem *goodOrderItem = [[GoodsOrderItem alloc]initWithGoodsName:foodName withCatagoryItem:subItem];
            [orderArray addObject:goodOrderItem];
            SafeRelease(goodOrderItem);
        }
    }
    self.dataArray = orderArray;
}

- (id)initWithFrame:(CGRect)frame  {

    if(self = [super initWithFrame:frame]) {
        
        //self.tableView.center = CGPointMake(frame.size.width/2.f, frame.size.height/2.f);
        
    }
}

- (void)showInView:(UIView*)view {
    NSInteger number= [self.dataArray count];
    if(number * 44.f>self.frame.size.height/2.f){
        
        self.tableView.frame = CGRectMake(0.f,self.frame.size.height/2.f,,)
    }
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
    return 44.f;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodSubItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if(cell == nil){
        
        cell = [[FoodSubItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
#if 1
    GoodsOrderItem *item = [self.dataArray objectAtIndex:indexPath.row];
    //cell.titleLable.text =  [NSString stringWithFormat:@"%@+%@",item.goodsName,item.name];
    [cell setFoodName:item.goodsName];
    [cell setCellItem:item];
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
