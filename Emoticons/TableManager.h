//
//  TableManager.h
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableManagerDelegate <NSObject>
@optional
- (void)tableView:(UITableView *)tableView didSelectParentCategory:(int)category_id;
- (void)tableView:(UITableView *)tableView didSelectChildCategory:(int)category_id AtRow:(int)row;
- (void)tableView:(UITableView *)tableView didSelectEmoticon:(int)emoticon_id;
- (void)tableViewFinishScrolling:(UITableView*)tableView;

@end

@interface TableManager : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<TableManagerDelegate> delegate;

@end
