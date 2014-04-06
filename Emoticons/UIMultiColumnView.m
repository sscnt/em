//
//  UIMultiColumnView.m
//  Emoticons
//
//  Created by SSC on 2014/04/05.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIMultiColumnView.h"

@implementation UIMultiColumnView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentPage = 1;
        _visibleSize = frame.size;
        _tableViewArray = [NSMutableArray array];
        _tableManagerArray = [NSMutableArray array];
        
        //// Scroll view
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollView];
        
        //// Title
        _titleView = [[UIMultiColumnTitleView alloc] initWithFrame:frame];
        [self addSubview:_titleView];
    }
    return self;
}

-(void)setVisibleSize:(CGSize)visibleSize
{
    _visibleSize = visibleSize;
    
}

-(void)setCurrentPage:(int)currentPage
{
    _currentPage = currentPage;
    _titleView.currentPage = currentPage;
    _scrollView.contentOffset = CGPointMake(_visibleSize.width * (CGFloat)(currentPage - 1), 0.0f);
    [self showTableAtPage:currentPage];
}

- (void)setCategoryObjectArray:(NSArray *)categoryObjectArray
{
    _numberOfPages = [categoryObjectArray count];
    _categoryObjectArray = categoryObjectArray;
}


#pragma mark layout

- (void)layout
{
    CGFloat titleHeight = 44.0f;
    CGRect tableViewFrame = CGRectMake(0.0f, 0.0f, _visibleSize.width, _visibleSize.height - titleHeight);
    CGRect titleViewFrame = CGRectMake(0.0f, 0.0f, _visibleSize.width, titleHeight);
    CGFloat titleLabelWidth = _visibleSize.width * 0.30f;
    CGSize titleViewContentsSize = CGSizeMake(titleLabelWidth * (CGFloat)_numberOfPages, titleHeight);
    _titleView.frame = titleViewFrame;
    _titleView.contentsSize = titleViewContentsSize;
    
    _scrollView.frame = CGRectMake(0.0f, titleHeight, _visibleSize.width, _visibleSize.height - titleHeight);;
    _scrollView.contentSize = CGSizeMake(_visibleSize.width * (CGFloat)_numberOfPages, _visibleSize.height - titleHeight);
    
    for (int i = 0; i < _numberOfPages; i++) {
        if([_categoryObjectArray objectAtIndex:i]){
            CategoryObject* cat = (CategoryObject*)[_categoryObjectArray objectAtIndex:i];
            EmoticonsTableManager* manager = [[EmoticonsTableManager alloc] init];
            manager.delegate = self;
            manager.categoryId = cat.id;
            UIEmoticonsTableView* table = [[UIEmoticonsTableView alloc] init];
            table.category_id = cat.id;
            table.page = i + 1;
            table.dataSource = manager;
            table.delegate = manager;
            table.frame = tableViewFrame;
            table.bounces = NO;
            [table setX:i * _visibleSize.width];
            table.backgroundColor = [UIColor clearColor];
            [_tableManagerArray addObject:manager];
            [_tableViewArray addObject:table];
            //[_scrollView addSubview:table];
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelWidth * (CGFloat)i, 0.0f, titleLabelWidth, titleHeight)];
            label.text = cat.name;
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = UITextAlignmentCenter;
            label.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:13.0f];
            label.minimumFontSize = 10.0f;
            label.adjustsFontSizeToFitWidth = YES;
            label.textColor = [UIColor blackColor];
            [_titleView addTitleView:label];
        }
    }
    
}

#pragma mark delegate

-(void)tableView:(UITableView *)tableView didSelectEmoticon:(int)emoticon_id
{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint currentPoint = [scrollView contentOffset];
    CGFloat w = scrollView.frame.size.width * (CGFloat)(_currentPage - 1);
    CGFloat ratio = (currentPoint.x - w) / scrollView.frame.size.width;
    if (ratio > 0.0f) {
        if(_currentPage < _numberOfPages){
            //// Presenting right
            [_titleView willPresentToPage:_currentPage + 1 WithRatio:ratio];
        }
    }else{
        if(_currentPage > 1){
            //// Presenting left
            ratio = -ratio;
            [_titleView willPresentToPage:_currentPage - 1 WithRatio:ratio];
        }
    }
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
    self.currentPage = roundf(fractionalPage) + 1;
}

- (void)showTableAtPage:(int)page
{
    if (page < 1 || page > [_tableViewArray count]) {
        return;
    }
    UIEmoticonsTableView* table = [_tableViewArray objectAtIndex:page - 1];
    if([table isDescendantOfView:_scrollView]){
        
    }else{
        [_scrollView addSubview:table];
    }
}

#pragma mark dealloc

- (void)dealloc
{
    [_tableManagerArray removeAllObjects];
    [_tableViewArray removeAllObjects];
    _scrollView.delegate = nil;
}

@end
