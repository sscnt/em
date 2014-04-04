//
//  TableManager.h
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableManagerDelegate <NSObject>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface TableManager : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<TableManagerDelegate> delegate;

@end
