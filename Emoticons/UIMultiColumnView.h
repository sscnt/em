//
//  UIMultiColumnView.h
//  Emoticons
//
//  Created by SSC on 2014/04/05.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIEmoticonsTableView.h"
#import "EmoticonsTableManager.h"

@interface UIMultiColumnView : UIView <UIScrollViewDelegate, TableManagerDelegate>
{
    NSUInteger _numberOfPages;
    UIScrollView* _columnScrollView;
    UIView* _columnTitleView;
    NSMutableArray* _tableViewArray;
    NSMutableArray* _tableManagerArray;
}

@property (nonatomic, assign) int parentCategoryId;
@property (nonatomic, strong) NSArray* categoryObjectArray;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, assign) CGSize visibleSize;

- (void)layout;

@end
