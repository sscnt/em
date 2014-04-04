//
//  CategoriesScrollManager.m
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "CategoriesScrollManager.h"

@implementation CategoriesScrollManager

static CategoriesScrollManager* sharedCategoriesScrollManager = nil;

+ (CategoriesScrollManager*)instance {
	@synchronized(self) {
		if (sharedCategoriesScrollManager == nil) {
			sharedCategoriesScrollManager = [[self alloc] init];
		}
	}
	return sharedCategoriesScrollManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedCategoriesScrollManager == nil) {
			sharedCategoriesScrollManager = [super allocWithZone:zone];
			return sharedCategoriesScrollManager;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

#pragma mark delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    _scrolling_direction = 0;
    _cancelDecelerating = NO;
    _scrollPrevPoint = [scrollView contentOffset];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_limitDirection){
        CGPoint currentPoint = [scrollView contentOffset];
        
        if (CGPointEqualToPoint(_scrollPrevPoint, currentPoint)){
            return;
        }
        else {
            //スクロール方向の判定
            _scrolling_direction = (_scrollPrevPoint.x < currentPoint.x) ? 2 : 1;
        }
        
        //下スクロールのキャンセル
        if (_scrolling_direction == 2)
        {
            currentPoint.x = _scrollPrevPoint.x;
            [scrollView setContentOffset:currentPoint];
            _cancelDecelerating = YES;
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //慣性スクロールを止める
    if (_cancelDecelerating){
        [scrollView setContentOffset:scrollView.contentOffset animated:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	// フリック操作によるスクロール終了
	[self scrollVIewFinishScrolling:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if(!decelerate) {
		// ドラッグ終了 かつ 加速無し
        [self scrollVIewFinishScrolling:scrollView];
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	// setContentOffset: 等によるスクロール終了
	[self scrollVIewFinishScrolling:scrollView];

}

- (void)scrollVIewFinishScrolling:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    [self.delegate scrollView:scrollView didPageChange:page + 1];
}

@end
