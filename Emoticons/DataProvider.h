//
//  DataProvider.h
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "CategoryObject.h"
#import "EmoticonObject.h"

@interface DataProvider : NSObject

@property (nonatomic, strong) NSMutableDictionary* childCategoryObjectsByCategoryIdCache;
@property (nonatomic, strong) NSArray* parentCategoryObjectsDefaultCache;
@property (nonatomic, strong) NSArray* parentCategoryObjectsUserAddedCache;

+ (void)cleanCaches;

+ (DataProvider*)instance;
+ (FMDatabase*)databaseWithFilename:(NSString*)filename;

+ (EmoticonObject*)emoticonObjectById:(int)emoticon_id;
+ (CategoryObject*)categoryObjectByCategoryId:(int)cattegory_id;

+ (NSArray*)parentCategoryObjectsDefault;
+ (NSArray*)parentCategoryObjectsUserAdded;
+ (NSArray*)childCategoryObjectsByCategoryId:(int)category_id;

+ (NSArray*)emoticonObjectsByCategoryId:(int)category_id;

@end
