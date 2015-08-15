//
//  LoginView.m
//  MobileOrder
//
//  Created by cszhan on 15-6-22.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "LoginView.h"

#import "DeviceVersion.h"

@implementation LoginView
@synthesize txtusername;
@synthesize txtpassword;
@synthesize autoLoginBtn;

- (void)awakeFromNib {

    [self initUIView];
}

- (void)initUIView {

    
    NSString  *username=@"";
    NSString  *password=@"";
    
    self.autoLoginBtn.selected = [AppSetting userAutoLogin];
#if 0
    //    UIImage *bgImage = nil;
    //    UIImageWithFileName(bgImage, @"login_bg.png");
    //    self.view.layer.contents = (id)bgImage.CGImage;
    //UIImageWithFileName(bgImage, @"login_bg.png");
#else
    _navBarView.backgroundColor = kNavBarColor;
    
#endif
    
    self.txtpassword.text = @"";
    self.txtusername.text = @"";
    if (![username isEqualToString:@""])
    {
        self.txtpassword.text=password;
        self.txtusername.text=username;
        
        //[self login_click:nil];
    }

    if(self.txtpassword)
    {
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")){
            NSMutableAttributedString *ms = [[NSMutableAttributedString alloc] initWithString:self.txtpassword.placeholder];
            UIFont *placeholderFont = self.txtpassword.font;
            NSRange fullRange = NSMakeRange(0, ms.length);
            NSDictionary *newProps = @{NSForegroundColorAttributeName: HexRGB(137, 137, 137), NSFontAttributeName:placeholderFont};
            [ms setAttributes:newProps range:fullRange];
            self.txtpassword.attributedPlaceholder = ms;
            SafeRelease(ms);
        }
        
    }
    //self.txtpassword.placeholder
    self.txtpassword.textColor = HexRGB(137, 137, 137);
    
    if(self.txtusername)
    {
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")){
            NSMutableAttributedString *ms = [[NSMutableAttributedString alloc] initWithString:txtusername.placeholder];
            UIFont *placeholderFont = self.txtusername.font;
            NSRange fullRange = NSMakeRange(0, ms.length);
            NSDictionary *newProps = @{NSForegroundColorAttributeName: HexRGB(137, 137, 137), NSFontAttributeName:placeholderFont};
            [ms setAttributes:newProps range:fullRange];
            self.txtusername.attributedPlaceholder = ms;
            SafeRelease(ms);
        }
    }
    
    self.txtusername.textColor = HexRGB(137, 137, 137);
    
}


- (IBAction)textFieldDidEndEditing:(id)sender
{
    [sender resignFirstResponder];
    
}
-(IBAction)login_click:(id)sender
{
    //[ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
    
    [self.txtusername resignFirstResponder];
    [self.txtpassword resignFirstResponder];
    //    if([self.txtusername.text length]<11)
    //    {
    //        kUIAlertView(@"提示", @"输入的手机号码不对");
    //        [self.txtusername becomeFirstResponder];
    //        return;
    //    }
    if([self.txtusername.text length] == 0|| [self.txtpassword.text length] ==0){
        kUIAlertView(@"提示", @"帐号或密码不能为空");
        [self.txtusername becomeFirstResponder];
        return;
    }
}
-(IBAction)regist_click:(id)sender
{
    
}
-(IBAction)findpw_click:(id)sender
{
    /*
     ResetPasswordViewController *resPsVc=[[ResetPasswordViewController alloc] init];
     resPsVc.type = 1;//forget password
     [self.navigationController pushViewController:resPsVc animated:YES];
     [resPsVc release];
     */
    //    if(self.isModel){
    //        [ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
    //    }
    //    else{
    //        [ZCSNotficationMgr postMSG:kUserDidLoginCancel obj:nil];
    //        //[self.navigationController  popToRootViewControllerAnimated:YES];
    //    }
    //
    [ZCSNotficationMgr postMSG:kUserDidLoginCancel obj:nil];
}


-(IBAction)cancelLogin:(id)sender
{
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
