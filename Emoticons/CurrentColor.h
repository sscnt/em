//
//  CurrentColor.h
//  Emoticons
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentColor : NSObject

+ (CurrentColor*)instance;

+ (UIColor*)dropshadowColor;

+ (UIColor*)backgroundColorTop;
+ (UIColor*)backgroundColorBottom;

+ (UIColor*)titleBarShadowColor;
+ (UIColor*)titleBarBorderColor;
+ (UIColor*)titleBarBackgroundColor;

+ (UIColor*)activeTextColor;

+ (UIColor*)cellNormalBackgroundColor;
+ (UIColor*)cellLightBorderColor;
+ (UIColor*)cellDarkBorderColor;

@end
