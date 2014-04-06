//
//  UIMultiColumnTitleView.h
//  Emoticons
//
//  Created by SSC on 2014/04/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMultiColumnTitleView : UIView
{
    CGFloat _padding;
    UIView* _contentsView;
    NSMutableArray* _labelArray;
}

@property (nonatomic, assign) int currentPage;
@property (nonatomic, assign) CGSize contentsSize;

- (void)addTitleView:(UIView *)view;
- (void)willPresentToPage:(int)page WithRatio:(float)ratio;
- (void)activateTextAtPage:(int)page;

@end
