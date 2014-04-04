//
//  DataProvider.m
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "DataProvider.h"

@implementation DataProvider

static DataProvider* sharedDataProvider = nil;

+ (DataProvider*)instance {
	@synchronized(self) {
		if (sharedDataProvider == nil) {
			sharedDataProvider = [[self alloc] init];
		}
	}
	return sharedDataProvider;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedDataProvider == nil) {
			sharedDataProvider = [super allocWithZone:zone];
			return sharedDataProvider;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

@end
