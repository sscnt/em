//
//  CurrentColor.h
//  Emoticons
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentColor : NSObject

@property (nonatomic, readonly) UIColor* backgroundColorTop;
@property (nonatomic, readonly) UIColor* backgroundColorBottom;
@property (nonatomic, readonly) UIColor* buttonColorTop;
@property (nonatomic, readonly) UIColor* buttonColorBottom;
@property (nonatomic, readonly) UIColor* textColor;
@property (nonatomic, readonly) UIColor* titleBarShadowColor;
@property (nonatomic, readonly) UIColor* titleBarBorderColor;
@property (nonatomic, readonly) UIColor* cellNormalBackgroundColor;

+ (CurrentColor*)sharedManager;

+ (UIColor*)titleBarShadowColor;
+ (UIColor*)titleBarBorderColor;

@end
