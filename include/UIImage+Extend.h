//
//  UIImage+Extend.h
//  DressMemo
//
//  Created by  on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage_Extend : NSObject

+(UIImage*)imageCroppedToFitSize:(CGSize)size withFileName:(NSString*)fileName;
+(UIImage *)imageCroppedToFitSize:(CGSize)size withData:(UIImage*)srcData;

+(UIImage*)imageCroppedToFitSizeII:(CGSize)size withData:(UIImage *)srcData;
+(UIImage*)imageCroppedToFitSizeII:(CGSize)size withFileName:(NSString*)fileName;

+(UIImage*)imageScaleToFitSize:(CGSize)size withFileName:(NSString*)fileName;
+(UIImage*)imageScaleToFitSize:(CGSize)size withData:(UIImage*)srcData;

+(UIImage *)makeRoundCornerImage:(UIImage*)img :(int) cornerWidth :(int) cornerHeight;
+(UIImage *)imageWithColor:(UIColor *)color;
+(UIImage *)imageWithColor:(UIColor *)color  withImage:(UIImage*)contentImage withSize:(CGSize)size;
+(UIImage *)imageWithColor:(UIColor *)color  withImage:(UIImage*)contentImage withSize:(CGSize)size withOffsetPoint:(CGPoint)offsetPoint;
@end
