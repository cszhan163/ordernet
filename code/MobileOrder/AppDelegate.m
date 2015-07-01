//
//  AppDelegate.m
//  MobileOrder
//
//  Created by cszhan on 15-5-26.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "AppDelegate.h"

#import "MainEntryViewController.h"

#import "NSString+Ex.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *text = @"士大夫偶家啊大噶说士大夫偶家啊大噶说士大夫偶家啊大噶说士大夫偶家啊大噶说士大夫偶家啊大噶说士大夫偶家啊大噶说士大夫偶家啊大噶说";
    CGSize size = [text sizeWithWidth:90.f withTextAttribute:@{kGoodCatagoryTextFont:NSFontAttributeName}];
    
    CGRect mainRect = [UIScreen mainScreen].bounds;
    
    //[[MobileOrderNetDataMgr getSingleTone] openSession];
    
   self.window = SafeAutoRelease(([[UIWindow alloc]initWithFrame:mainRect]));
 
    MainEntryViewController *mainViewCtrl = [[MainEntryViewController alloc]init];
    
    UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:mainViewCtrl];
    
    //[navCtrl.navigationBar]
    SafeRelease(mainViewCtrl);
    [self.window addSubview:navCtrl.view];
    if(!kIsIOS7Check){
        //self.window.frame = CGRectMake(0.f,-20.f,mainRect.size.width, mainRect.size.height+20.f);
        [navCtrl setNavigationBarHidden:YES];
        
    }
    //[navCtrl setNavigationBarHidden:YES];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = navCtrl;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
  
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
