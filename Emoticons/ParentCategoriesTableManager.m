//
//  ParentCategoriesDataSource.m
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "ParentCategoriesTableManager.h"

@implementation ParentCategoriesTableManager

static ParentCategoriesTableManager* sharedParentCategoriesDataSource = nil;

+ (ParentCategoriesTableManager*)instance {
	@synchronized(self) {
		if (sharedParentCategoriesDataSource == nil) {
			sharedParentCategoriesDataSource = [[self alloc] init];
		}
	}
	return sharedParentCategoriesDataSource;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedParentCategoriesDataSource == nil) {
			sharedParentCategoriesDataSource = [super allocWithZone:zone];
			return sharedParentCategoriesDataSource;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

#pragma mark table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"hoge";
    
    return cell;
}

#pragma mark table events

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
