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
#import "UIMultiColumnTitleView.h"

@protocol UIMultiColumnViewDelegate <NSObject>
- (void)didSelectEmoticon:(int)emoticon_id;
@end

@interface UIMultiColumnView : UIView <UIScrollViewDelegate, TableManagerDelegate>
{
    NSUInteger _numberOfPages;
    int _currentPage;
    UIScrollView* _scrollView;
    UIMultiColumnTitleView* _titleView;
    NSMutableArray* _tableViewArray;
    NSMutableArray* _tableManagerArray;
}

@property (nonatomic, assign) int parentCategoryId;
@property (nonatomic, strong) NSArray* categoryObjectArray;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, assign) CGSize visibleSize;
@property (nonatomic, weak) id<UIMultiColumnViewDelegate> delegate;

- (void)layout;
- (void)showTableAtPage:(int)page;

@end
