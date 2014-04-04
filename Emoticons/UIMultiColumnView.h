//
//  UIMultiColumnView.h
//  Emoticons
//
//  Created by SSC on 2014/04/05.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMultiColumnView : UIView
{
    UIScrollView* columnScrollView;
    UIView* columnTitleView;
    NSMutableArray* categoryObjectArray;
    NSMutableArray* tableViewArray;
}

@property (nonatomic, assign) int numberOfPages;
@property (nonatomic, assign) int currentPage;

@end
