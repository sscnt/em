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
        _visibleSize = frame.size;
        _tableViewArray = [NSMutableArray array];
        _tableManagerArray = [NSMutableArray array];
        
        //// Scroll view
        _columnScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _columnScrollView.delegate = self;
        _columnScrollView.showsHorizontalScrollIndicator = NO;
        _columnScrollView.showsVerticalScrollIndicator = NO;
        _columnScrollView.pagingEnabled = YES;
        _columnScrollView.bounces = NO;
        _columnScrollView.scrollEnabled = YES;
        _columnScrollView.backgroundColor = [UIColor blueColor];
        [self addSubview:_columnScrollView];
        
        //// Title
        _columnTitleView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_columnTitleView];
    }
    return self;
}

-(void)setVisibleSize:(CGSize)visibleSize
{
    _visibleSize = visibleSize;
    
}

-(void)setCurrentPage:(int)currentPage
{
    
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
    CGRect titleViewFrame = CGRectMake(0.0f, 0.0f, _visibleSize.width * _numberOfPages, titleHeight);
    _columnTitleView.frame = titleViewFrame;
    
    _columnScrollView.frame = CGRectMake(0.0f, titleHeight, _visibleSize.width, _visibleSize.height - titleHeight);;
    _columnScrollView.contentSize = CGSizeMake(_visibleSize.width * _numberOfPages, _visibleSize.height - titleHeight);
    
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
            table.backgroundColor = [UIColor redColor];
            [_tableManagerArray addObject:manager];
            [_tableViewArray addObject:table];
            [_columnScrollView addSubview:table];
        }
    }
    
}

#pragma mark delegate

-(void)tableView:(UITableView *)tableView didSelectEmoticon:(int)emoticon_id
{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
    
}


@end
