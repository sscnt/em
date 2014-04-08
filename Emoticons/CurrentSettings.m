//
//  CurrentSettings.m
//  Emoticons
//
//  Created by SSC on 2014/04/08.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "CurrentSettings.h"

@implementation CurrentSettings

static CurrentSettings* sharedCurrentSettings = nil;

+ (CurrentSettings*)instance {
	@synchronized(self) {
		if (sharedCurrentSettings == nil) {
			sharedCurrentSettings = [[self alloc] init];
		}
	}
	return sharedCurrentSettings;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedCurrentSettings == nil) {
			sharedCurrentSettings = [super allocWithZone:zone];
			return sharedCurrentSettings;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

#pragma mark text

+ (CGFloat)textSizeForEditor
{
    return 16.0f;
}

@end
