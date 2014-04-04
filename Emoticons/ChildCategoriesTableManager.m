//
//  ChildCategoriesTableManager.m
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "ChildCategoriesTableManager.h"

@implementation ChildCategoriesTableManager

static ChildCategoriesTableManager* sharedChildCategoriesDataSource = nil;

+ (ChildCategoriesTableManager*)instance {
	@synchronized(self) {
		if (sharedChildCategoriesDataSource == nil) {
			sharedChildCategoriesDataSource = [[self alloc] init];
		}
	}
	return sharedChildCategoriesDataSource;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedChildCategoriesDataSource == nil) {
			sharedChildCategoriesDataSource = [super allocWithZone:zone];
			return sharedChildCategoriesDataSource;
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
    UICategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UICategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"fuga";
    
    return cell;
}

#pragma mark table events

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate tableView:tableView didSelectChildCategory:2];
}

@end
