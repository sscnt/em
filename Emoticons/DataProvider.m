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

- (id)init
{
    self = [super init];
    if(self){
        _childCategoryObjectsInDefaultParentCategoryCache = [NSMutableDictionary dictionary];
        _childCategoryObjectsInUserParentCategoryCache = [NSMutableDictionary dictionary];
        _parentCategoryObjectsInDefaultTable = nil;
        _parentCategoryObjectsInUserTable = nil;
    }
    return self;
}

+ (void)cleanCaches
{
    [[self instance].childCategoryObjectsInDefaultParentCategoryCache removeAllObjects];
    [self instance].childCategoryObjectsInDefaultParentCategoryCache = [NSMutableDictionary dictionary];
    [[self instance].childCategoryObjectsInUserParentCategoryCache removeAllObjects];
    [self instance].childCategoryObjectsInUserParentCategoryCache = [NSMutableDictionary dictionary];
    [self instance].parentCategoryObjectsInDefaultTable = nil;
    [self instance].parentCategoryObjectsInDefaultTable = nil;
}

#pragma mark Datagase

+(FMDatabase *)databaseWithFilename:(NSString *)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *databasePath = [path stringByAppendingPathComponent:filename];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    
    // 文章フォルダにデータベースファイルが存在しているかを確認する
    if (![manager fileExistsAtPath:databasePath]) {
        
        // 文章フォルダに存在しない場合は、データベースをコピーする
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
        BOOL success = [manager copyItemAtPath:defaultDBPath toPath:databasePath error:&error];
        
        if (success) {
            LOG(@"Database file %@ copied.", filename);
        } else {
            NSLog(@"Error: %@", error);
            return nil;
        }
    } else {
        NSLog(@"Database file %@ already exist.", filename);
    }
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    return db;
}

#pragma mark Category

+ (NSArray*)parentCategoryObjectsInDefaultTable
{
    NSArray* result = [self instance].parentCategoryObjectsInDefaultTable;
    if(result){
        return result;
    }
    NSMutableArray* _result = [NSMutableArray array];
    FMDatabase* db = [self databaseWithFilename:@"categories.sqlite"];
    if(!db){
        LOG(@"db is nil.");
        return nil;
    }
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM \"default\" WHERE \"parent_id\" == 0 ORDER BY \"order\" ASC;"];
        while ([rs next]) {
            CategoryObject* cat = [[CategoryObject alloc] init];
            cat.id = [rs intForColumn:@"id"];
            cat.name = [rs stringForColumn:@"name"];
            cat.parent_id = [rs intForColumn:@"parent_id"];
            [_result addObject:cat];
        }
        [rs close];
        [db close];
    }else{
        //DBが開けなかったらここ
        LOG(@"cannot open database");
    }
    result = [_result copy];
    [self instance].parentCategoryObjectsInDefaultTable = result;
    return result;

}

+ (NSArray *)childCategoryObjectsInDefaultParentCategoryId:(int)category_id
{
    NSArray* result = [[self instance].childCategoryObjectsInDefaultParentCategoryCache objectForKey:[NSString stringWithFormat:@"%d", category_id]];
    if(result){
        return result;
    }
    NSMutableArray* _result = [NSMutableArray array];
    FMDatabase* db = [self databaseWithFilename:@"categories.sqlite"];
    if(!db){
        LOG(@"db is nil.");
        return nil;
    }
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM \"default\" WHERE \"parent_id\" == 1 ORDER BY \"order\" ASC;"];
        while ([rs next]) {
            CategoryObject* cat = [[CategoryObject alloc] init];
            cat.id = [rs intForColumn:@"id"];
            cat.name = [rs stringForColumn:@"name"];
            cat.parent_id = [rs intForColumn:@"parent_id"];
            [_result addObject:cat];
        }
        [rs close];
        [db close];
    }else{
        //DBが開けなかったらここ
        LOG(@"cannot open database");
    }
    result = [_result copy];
    [[self instance].childCategoryObjectsInDefaultParentCategoryCache setObject:result forKey:[NSString stringWithFormat:@"%d", category_id]];
    return result;
}

@end
