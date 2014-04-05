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
        _childCategoryObjectsByCategoryIdCache = [NSMutableDictionary dictionary];
        _emoticonsObjectsByCategoryIdCache = [NSMutableDictionary dictionary];
        _parentCategoryObjectsDefaultCache = nil;
        _parentCategoryObjectsUserAddedCache = nil;
    }
    return self;
}

+ (void)cleanCaches
{
    [[self instance].childCategoryObjectsByCategoryIdCache removeAllObjects];
    [self instance].childCategoryObjectsByCategoryIdCache = [NSMutableDictionary dictionary];
    [self instance].parentCategoryObjectsDefaultCache = nil;
    [self instance].parentCategoryObjectsUserAddedCache = nil;
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
            
            NSURL *databaseUrl = [NSURL fileURLWithPath:databasePath];
            if(![UIDevice addSkipBackupAttributeToItemAtURL:databaseUrl]){
                LOG(@"Failed to add skip attr.");
            }
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

+ (NSArray*)parentCategoryObjectsDefault
{
    NSArray* result = [self instance].parentCategoryObjectsDefaultCache;
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
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM \"categories\" WHERE \"parent_id\" == 0 AND \"added_by_user\" == 0 ORDER BY \"order\" ASC;"];
        while ([rs next]) {
            CategoryObject* cat = [[CategoryObject alloc] init];
            cat.id = [rs intForColumn:@"id"];
            cat.name = [rs stringForColumn:@"name"];
            cat.parentId = [rs intForColumn:@"parent_id"];
            [_result addObject:cat];
        }
        [rs close];
        [db close];
    }else{
        //DBが開けなかったらここ
        LOG(@"cannot open database");
    }
    result = [_result copy];
    [self instance].parentCategoryObjectsDefaultCache = result;
    return result;

}

+ (NSArray*)parentCategoryObjectsUserAdded
{
    NSArray* result = [self instance].parentCategoryObjectsDefaultCache;
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
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM \"categories\" WHERE \"parent_id\" == 0 AND \"added_by_user\" == 1 ORDER BY \"order\" ASC;"];
        while ([rs next]) {
            CategoryObject* cat = [[CategoryObject alloc] init];
            cat.id = [rs intForColumn:@"id"];
            cat.name = [rs stringForColumn:@"name"];
            cat.parentId = [rs intForColumn:@"parent_id"];
            [_result addObject:cat];
        }
        [rs close];
        [db close];
    }else{
        //DBが開けなかったらここ
        LOG(@"cannot open database");
    }
    result = [_result copy];
    [self instance].parentCategoryObjectsDefaultCache = result;
    return result;
    
}

+ (NSArray *)childCategoryObjectsByCategoryId:(int)category_id
{
    NSArray* result = [[self instance].childCategoryObjectsByCategoryIdCache objectForKey:[NSString stringWithFormat:@"%d", category_id]];
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
        
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM \"categories\" WHERE \"parent_id\" == %d ORDER BY \"order\" ASC;", category_id]];
        while ([rs next]) {
            CategoryObject* cat = [[CategoryObject alloc] init];
            cat.id = [rs intForColumn:@"id"];
            cat.name = [rs stringForColumn:@"name"];
            cat.parentId = [rs intForColumn:@"parent_id"];
            [_result addObject:cat];
        }
        [rs close];
        [db close];
    }else{
        //DBが開けなかったらここ
        LOG(@"cannot open database");
    }
    result = [_result copy];
    [[self instance].childCategoryObjectsByCategoryIdCache setObject:result forKey:[NSString stringWithFormat:@"%d", category_id]];
    return result;
}

#pragma mark Emoticons


+ (NSArray *)emoticonObjectsByCategoryId:(int)category_id
{
    NSArray* result = [[self instance].emoticonsObjectsByCategoryIdCache objectForKey:[NSString stringWithFormat:@"%d", category_id]];
    if(result){
        return result;
    }
    NSMutableArray* _result = [NSMutableArray array];
    FMDatabase* db = [self databaseWithFilename:@"emoticons.sqlite"];
    if(!db){
        LOG(@"db is nil.");
        return nil;
    }
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM \"dictionary\" WHERE \"category_id\" == %d ORDER BY \"last_used_time\" DESC;", category_id]];
        while ([rs next]) {
            EmoticonObject* emo = [[EmoticonObject alloc] init];
            emo.id = [rs intForColumn:@"id"];
            emo.emoticon = [rs stringForColumn:@"emoticon"];
            emo.categoryId = [rs intForColumn:@"category_id"];
            emo.lastUsedTime = [rs intForColumn:@"last_used_time"];
            emo.addedByUser = ([rs intForColumn:@"added_by_user"] == 0) ? NO : YES;
            [_result addObject:emo];
        }
        [rs close];
        [db close];
    }else{
        //DBが開けなかったらここ
        LOG(@"cannot open database");
    }
    result = [_result copy];
    [[self instance].emoticonsObjectsByCategoryIdCache setObject:result forKey:[NSString stringWithFormat:@"%d", category_id]];
    return result;
}

@end
