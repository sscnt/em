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

@property (nonatomic, strong) NSMutableDictionary* childCategoryObjectsInDefaultParentCategoryCache;
@property (nonatomic, strong) NSMutableDictionary* childCategoryObjectsInUserParentCategoryCache;
@property (nonatomic, strong) NSArray* parentCategoryObjectsInDefaultTable;
@property (nonatomic, strong) NSArray* parentCategoryObjectsInUserTable;

+ (void)cleanCaches;

+ (DataProvider*)instance;
+ (FMDatabase*)databaseWithFilename:(NSString*)filename;

+ (CategoryObject*)categoryObjectByCategoryId:(int)cattegory_id;

+ (NSArray*)parentCategoryObjectsInDefaultTable;
+ (NSArray*)childCategoryObjectsInDefaultParentCategoryId:(int)category_id;

@end
