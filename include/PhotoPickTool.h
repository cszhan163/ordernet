//
//  PhotoPickTool.h
//  NetEaseBlogIphone
//
//  Created by cszhan on 8/30/10.
//  Copyright 2010 NetEase Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Constants.h"
#define  kUploadPhotoPickChooseMSG              @"uploadPhotoPickChooseMSG"
#define  kUploadPhotoPickChooseEditMSG          @"uploadPhotoPickChooseEditMSG"
@protocol PhotoPickToolDelegate<NSObject>
@optional
-(void)didPostPhoto:(id)data withStatus:(BOOL)status;
-(void)cancelPost:(BOOL)Status;
-(void)didGetImageData:(id)data;
@end
@interface PhotoPickTool : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
		id<PhotoPickToolDelegate>	delegate;
		UIViewController		*controllerDelegate;
}
+(id)getSingleTone;
-(id)initWithViewControler:(id)controller;
-(BOOL)pickPhotoFromLib;
-(BOOL)pickPhotoFromCamara;
@property(nonatomic,assign) id<PhotoPickToolDelegate>   delegate;
@property(nonatomic,assign) UIViewController            *controllerDelegate;
@end
