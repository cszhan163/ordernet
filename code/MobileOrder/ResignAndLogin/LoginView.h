//
//  LoginView.h
//  MobileOrder
//
//  Created by cszhan on 15-6-22.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LogViewDelegate <NSObject>

- (void)didLoginAction:(id)sender;

@end

@interface LoginView : UIView {


    //    IBOutlet UITextField *txtusername;
    //    IBOutlet UITextField *txtpassword;
    
}

@property (nonatomic, assign) IBOutlet UIView *navBarView;
@property(nonatomic,retain) IBOutlet UITextField *txtusername;
@property(nonatomic,retain) IBOutlet UITextField *txtpassword;
@property (nonatomic,retain) IBOutlet UIButton   *autoLoginBtn;

@end
