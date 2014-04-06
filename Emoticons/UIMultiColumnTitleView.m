//
//  UIMultiColumnTitleView.m
//  Emoticons
//
//  Created by SSC on 2014/04/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIMultiColumnTitleView.h"

@implementation UIMultiColumnTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _padding = 20.0f;
        _currentPage = 0;
        _labelArray = [NSMutableArray array];
        self.backgroundColor = [UIColor colorWithWhite:0.98f alpha:1.0f];
        self.clipsToBounds = YES;
        _contentsView = [[UIView alloc] initWithFrame:frame];
        _contentsView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentsView];
    }
    return self;
}

- (void)addTitleView:(UIView *)view
{
    [view setX:view.frame.origin.x + _padding];
    [_labelArray addObject:view];
    [_contentsView addSubview:view];
}

- (void)setContentsSize:(CGSize)contentsSize
{
    _contentsSize = CGSizeMake(contentsSize.width + _padding * 2.0f, contentsSize.height);
    _contentsView.frame = CGRectMake(0.0f, 0.0f, contentsSize.width, contentsSize.height);
}

- (void)activateTextAtPage:(int)page
{
    if(page < 1 || page > [_labelArray count]){
        return;
    }
    for (int i = 0; i < [_labelArray count]; i++) {
        UILabel* targetlabel = [_labelArray objectAtIndex:i];
        if(i + 1 == page){
            targetlabel.textColor = [CurrentColor activeTextColor];
        }else{
            targetlabel.textColor = [UIColor blackColor];
        }
    }
}

- (void)setCurrentPage:(int)currentPage
{
    if(currentPage < 1 || currentPage > [_labelArray count]){
        return;
    }
    _currentPage = currentPage;
    UILabel* targetlabel = [_labelArray objectAtIndex:currentPage - 1];
    CGFloat targetCenter = targetlabel.center.x;
    CGFloat originX = self.frame.size.width / 2.0f - targetCenter;
    originX = MAX(-_contentsSize.width + self.frame.size.width, MIN(0.0f, originX));
    [_contentsView setX:originX];
    [self activateTextAtPage:currentPage];
}

-(void)willPresentToPage:(int)page WithRatio:(float)ratio
{
    UILabel* targetlabel = [_labelArray objectAtIndex:page - 1];
    CGFloat targetCenter = targetlabel.center.x;
    CGFloat originX = self.frame.size.width / 2.0f - targetCenter;
    if(page > _currentPage){
        originX += (1.0f - ratio) * targetlabel.frame.size.width;
    }else{
        originX -= (1.0f - ratio) * targetlabel.frame.size.width;
    }
    originX = MAX(-_contentsSize.width + self.frame.size.width, MIN(0.0f, originX));
    [_contentsView setX:originX];
}

- (void)drawRect:(CGRect)rect
{
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, rect.size.height - 3.0f, rect.size.width, 0.5)];
    [[UIColor whiteColor] setFill];
    [rectanglePath fill];
    
    //// Rectangle Drawing
    rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, rect.size.height - 2.5f, rect.size.width, 2.0f)];
    [[CurrentColor titleBarShadowColor] setFill];
    [rectanglePath fill];
    
    //// Rectangle Drawing
    rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, rect.size.height - 0.50f, rect.size.width, 0.5)];
    [[CurrentColor titleBarBorderColor] setFill];
    [rectanglePath fill];
}

-(void)dealloc
{
    [_labelArray removeAllObjects];
}


@end
