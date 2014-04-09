//
//  CurrentColor.m
//  Emoticons
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "CurrentColor.h"

@implementation CurrentColor

static CurrentColor* sharedCurrentColor = nil;

+ (CurrentColor*)instance {
	@synchronized(self) {
		if (sharedCurrentColor == nil) {
			sharedCurrentColor = [[self alloc] init];
		}
	}
	return sharedCurrentColor;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedCurrentColor == nil) {
			sharedCurrentColor = [super allocWithZone:zone];
			return sharedCurrentColor;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

+ (UIColor*)dropshadowColor
{
    return [UIColor colorWithRed:128.0f/255.0f green:32.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
}

#pragma mark Background Color

+ (UIColor*)backgroundColorTop
{
    return [UIColor colorWithRed:238.0f/255.0f green:80.0f/255.0f blue:53.0f/255.0f alpha:1.0f];
}

+ (UIColor*)backgroundColorBottom
{
    return [UIColor colorWithRed:208.0f/255.0f green:54.0f/255.0f blue:30.0f/255.0f alpha:1.0f];
}

#pragma mark Title Color

+ (UIColor*)titleBarShadowColor
{
    return [UIColor colorWithRed:240.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
}

+ (UIColor*)titleBarBorderColor
{
    return [UIColor colorWithRed:204.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
}

+ (UIColor*)titleBarBackgroundColor
{
    return [UIColor colorWithRed:255.0f/255.0f green:248.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
}

#pragma mark General

+ (UIColor *)activeTextColor
{
    return [UIColor colorWithRed:194.0f/255.0f green:65.0f/255.0f blue:43.0f/255.0f alpha:1.0f];
}

+ (UIColor *)normalTextColor
{
    return [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
}

#pragma mark Cell

+ (UIColor*)cellNormalBackgroundColor
{
    return [UIColor colorWithRed:250.0f/255.0f green:246.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
}

+ (UIColor*)cellLightBorderColor
{
    return [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
}

+ (UIColor*)cellDarkBorderColor
{
    return [UIColor colorWithRed:204.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
}

#pragma mark Draggable

+ (UIColor*)draggableEmoticonViewBgColor
{
    return [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
}

+ (UIColor*)draggableEmoticonViewKnobColor
{
    return [UIColor colorWithRed:240.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
}

+ (UIColor*)draggableEmoticonViewKnobShadowColor
{
    return [UIColor colorWithRed:204.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
}

#pragma mark hint

+ (UIColor*)hintArrowColor
{
    return [UIColor colorWithRed:204.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
}



@end
