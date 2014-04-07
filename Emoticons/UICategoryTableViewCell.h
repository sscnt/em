//
//  UICategoryTableViewCell.h
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICategoryTableViewCell : UITableViewCell
{
    BOOL _highlighted;
}

@property (nonatomic, assign) BOOL isTopCell;
@property (nonatomic, assign) BOOL isBottomCell;

@end
