//
//  ParentCategoriesDataSource.h
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "TableManager.h"
#import "UICategoryTableViewCell.h"

@interface ParentCategoriesTableManager : TableManager

@property (nonatomic, assign) int numberOfRows;

+ (ParentCategoriesTableManager*)instance;

@end
