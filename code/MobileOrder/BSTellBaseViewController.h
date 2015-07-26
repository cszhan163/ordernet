//
//  BSTellBaseViewController.h
//  BSTell
//
//  Created by cszhan on 14-1-31.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "UISimpleNetBaseViewController.h"
#import "BSTellTimerReflushDataProcotol.h"
@interface BSTellBaseViewController : UISimpleNetBaseViewController<UIBaseViewControllerDelegate,BSTellTimerReflushDataProcotol>{
    CGFloat offsetY;
    UIScrollView *contentView;
}
@property(nonatomic,strong)NSString *wtid;

@property (nonatomic, assign) BOOL isShowLogin;

@property   (nonatomic,strong)  NSTimer *timer;

@property   (nonatomic,assign) BOOL needLogin;

@property   (nonatomic,assign) BOOL isLoginOk;

@property   (nonatomic,assign) NoteType type;

@property   (nonatomic,strong) NSString *userId;

@property   (nonatomic,strong) NSString *czy;


- (void)setNavgationBarRightButton:(NSString*)title;

- (void)setHiddenLeftBtn:(BOOL)hidden;

- (void)setLeftNavigationBarItem;

@end
