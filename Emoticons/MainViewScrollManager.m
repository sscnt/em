//
//  MainViewScrollManager.m
//  Emoticons
//
//  Created by SSC on 2014/04/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "MainViewScrollManager.h"

@implementation MainViewScrollManager

static MainViewScrollManager* sharedMainViewScrollManager = nil;

+ (MainViewScrollManager*)instance {
	@synchronized(self) {
		if (sharedMainViewScrollManager == nil) {
			sharedMainViewScrollManager = [[self alloc] init];
		}
	}
	return sharedMainViewScrollManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedMainViewScrollManager == nil) {
			sharedMainViewScrollManager = [super allocWithZone:zone];
			return sharedMainViewScrollManager;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

#pragma mark delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.delegate scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	// フリック操作によるスクロール終了
	[self scrollViewFinishScrolling:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if(!decelerate) {
		// ドラッグ終了 かつ 加速無し
        [self scrollViewFinishScrolling:scrollView];
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	// setContentOffset: 等によるスクロール終了
	[self scrollViewFinishScrolling:scrollView];
    
}

- (void)scrollViewFinishScrolling:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if(_currentPage != (int)page){
        [self.delegate scrollView:scrollView didPageChange:(int)page + 1];
        _currentPage = (int)page;
    }
    [self.delegate scrollViewEndScroll:scrollView];
}

@end
