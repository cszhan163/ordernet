//
//  frmLogin.h
//  kkshop
//
//  Created by apple  on 12-8-7.
//
//

#import <UIKit/UIKit.h>
#import "UISimpleNetBaseViewController.h"

typedef  void (^BlockWithSender)(id sender);

@protocol UserLoginViewControllerDelegate

@end
@interface CardShopLoginViewController :UIViewController
{
//    IBOutlet UITextField *txtusername;
//    IBOutlet UITextField *txtpassword;
 //   IBOutlet UIView *navBarView;
}

@property(nonatomic,assign)id request;
@property (nonatomic, strong) NSString *useId;

@property (nonatomic, strong) NSString *userName;

- (void)setCompleteAction:(BlockWithSender) block;

- (void)setCancelAction:(BlockWithSender) block;

@property(nonatomic,assign) BOOL isModel;
- (IBAction)textFieldDidEndEditing:(id)sender ;
- (IBAction)login_click:(id)sender;
- (IBAction)regist_click:(id)sender;
- (IBAction)findpw_click:(id)sender;
- (IBAction)cancelLogin:(id)sender;
- (IBAction)autoLoginClick:(id)sender;
@end
