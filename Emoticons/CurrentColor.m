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

+ (CurrentColor*)sharedManager {
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

+ (UIColor*)titleBarShadowColor
{
    return [UIColor colorWithRed:237.0f/255.0f green:239.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
}

+ (UIColor*)titleBarBorderColor
{
    return [UIColor colorWithRed:202.0f/255.0f green:206.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
}



@end
