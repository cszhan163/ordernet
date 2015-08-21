//
//  RegisterView.h
//  MobileOrder
//
//  Created by cszhan on 15-8-17.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView

@property(nonatomic,assign)NSInteger type;
@property(nonatomic,retain)IBOutlet UILabel  *navTitleLabel;
@property(nonatomic,retain)IBOutlet UITextField *mobilePhoneTextFied;
@property(nonatomic,retain)IBOutlet UITextField *radomCodeTextFied;
@property(nonatomic,retain)IBOutlet UITextField *phoneCodeTextFied;
@property(nonatomic,retain)IBOutlet UITextField *passwordTextFied;
@property(nonatomic,retain)IBOutlet UITextField *confirmPasswordTextFied;
@property(nonatomic,retain)NSString *mobilePhoneNumStr;

@property (nonatomic,strong) IBOutlet UIButton *radomCodeBtn;

@property (nonatomic,strong) IBOutlet UIButton *phoneCodeBtn;

@end
