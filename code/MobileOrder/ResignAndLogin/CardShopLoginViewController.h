//
//  frmLogin.h
//  kkshop
//
//  Created by apple  on 12-8-7.
//
//

#import <UIKit/UIKit.h>
#import "UISimpleNetBaseViewController.h"
@protocol UserLoginViewControllerDelegate

@end
@interface CardShopLoginViewController :UISimpleNetBaseViewController
{
    IBOutlet UITextField *txtusername;
    IBOutlet UITextField *txtpassword;
    IBOutlet UIView *navBarView;
}
@property(nonatomic,retain) IBOutlet UITextField *txtusername;
@property(nonatomic,retain) IBOutlet UITextField *txtpassword;

@property (nonatomic, strong) NSString *useId;

@property (nonatomic, strong) NSString *userName;

@property(nonatomic,assign) BOOL isModel;
- (IBAction)textFieldDidEndEditing:(id)sender ;
-(IBAction)login_click:(id)sender;
-(IBAction)regist_click:(id)sender;
-(IBAction)findpw_click:(id)sender;
-(IBAction)cancelLogin:(id)sender;
@end
