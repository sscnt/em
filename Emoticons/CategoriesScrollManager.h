//
//  CategoriesScrollManager.h
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CategoriesScrollManagerDelegate <NSObject>
@optional
-(void)scrollView:(UIScrollView *)scrollView didPageChange:(int)page;
-(void)scrollViewWillPresentToPreviousPage:(UIScrollView *)scrollView;

@end

@interface CategoriesScrollManager : NSObject <UIScrollViewDelegate>
{
    CGPoint _scrollPrevPoint;
    BOOL _cancelDecelerating;
    int _scrolling_direction;
    int _currentPage;
}

@property (nonatomic, assign) BOOL limitDirection;
@property (nonatomic, weak) id<CategoriesScrollManagerDelegate> delegate;

+ (CategoriesScrollManager*)instance;

@end
