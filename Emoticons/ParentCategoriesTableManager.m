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
    NSArray* categories = [DataProvider parentCategoryObjectsInDefaultTable];
    self.numberOfRows = [categories count];
    return self.numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UICategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UICategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSArray* categories = [DataProvider parentCategoryObjectsInDefaultTable];
    CategoryObject* cat = [categories objectAtIndex:indexPath.row];
    if(cat){
        cell.textLabel.text = cat.name;
    }
    
    
    return cell;

}

#pragma mark table events

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate tableView:tableView didSelectParentCategory:1];
}

@end
