//
//  UIEmoticonsChooserView.m
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIEmoticonsChooserView.h"

@implementation UIEmoticonsChooserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentPage = UIEmoticonChooserCurrentPageIdParentCategory;
        
        //// show only at loading
        _dammyBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, frame.size.width, frame.size.height)];
        _dammyBackgroundView.backgroundColor = [CurrentColor cellNormalBackgroundColor];
        [self addSubview:_dammyBackgroundView];
        
        //// Wrapper view
        _view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _view.backgroundColor = [UIColor clearColor];
        _view.layer.masksToBounds = YES;
        _view.layer.cornerRadius = 3.0f;
        [self addSubview:_view];
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.shadowOpacity = 0.7f;
        self.layer.shadowColor = [CurrentColor dropshadowColor].CGColor;
        self.layer.shadowRadius = 4.0f;
        
        //// Title
        _titleBarView = [[UITitleBarView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, 44.0f)];
        [_titleBarView setTitle:NSLocalizedString(@"Categories", nil)];
        [self.view addSubview:_titleBarView];
        
        //// Category list scroll view
        _categoriesScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _categoriesScrollView.delegate = [CategoriesScrollManager instance];
        _categoriesScrollView.showsHorizontalScrollIndicator = NO;
        _categoriesScrollView.showsVerticalScrollIndicator = NO;
        _categoriesScrollView.pagingEnabled = YES;
        _categoriesScrollView.bounces = NO;
        _categoriesScrollView.scrollEnabled = NO;
        [self.view addSubview:_categoriesScrollView];
        [CategoriesScrollManager instance].delegate = self;
        
        //// Parent categories table view
        _parentCategoriesTableView = [[UITableView alloc] initWithFrame:frame];
        _parentCategoriesTableView.delegate = [ParentCategoriesTableManager instance];
        _parentCategoriesTableView.dataSource = [ParentCategoriesTableManager instance];
        _parentCategoriesTableView.backgroundColor = [UIColor clearColor];
        [ParentCategoriesTableManager instance].delegate = self;
        _parentCategoriesTableView.tag = UIEmoticonChooserCategoryTableIdParent;
        [_categoriesScrollView addSubview:_parentCategoriesTableView];
        
        
        [ChildCategoriesTableManager instance].delegate = self;
    }
    return self;
}

- (void)setVisibleSize:(CGSize)visibleSize
{
    _visibleSize = visibleSize;
    CGRect scrollViewVisibleRect = CGRectMake(0.0f, [_titleBarView bottom], _categoriesScrollView.frame.size.width, visibleSize.height - _titleBarView.frame.size.height);
    CGRect categoryTableVisibleRect = CGRectMake(0.0f, 0.0f, _categoriesScrollView.frame.size.width, visibleSize.height - _titleBarView.frame.size.height);
    
    //// Scroll
    _categoriesScrollView.frame = scrollViewVisibleRect;
    _categoriesScrollView.contentSize = CGSizeMake(_categoriesScrollView.frame.size.width * 3.0f, _categoriesScrollView.frame.size.height);
    
    //// Category
    _parentCategoriesTableView.frame = categoryTableVisibleRect;
}

#pragma mark Placement

- (void)placeChildCategoryTableView
{
    if(_childCategoriesTableView){
        [_childCategoriesTableView removeFromSuperview];
        _childCategoriesTableView = nil;
    }
    
    CGRect categoryTableVisibleRect = CGRectMake(_visibleSize.width, 0.0f, _categoriesScrollView.frame.size.width, _visibleSize.height - _titleBarView.frame.size.height);
    
    _childCategoriesTableView = [[UITableView alloc] initWithFrame:categoryTableVisibleRect];
    _childCategoriesTableView.delegate = [ChildCategoriesTableManager instance];
    _childCategoriesTableView.dataSource = [ChildCategoriesTableManager instance];
    _childCategoriesTableView.backgroundColor = [UIColor clearColor];
    _childCategoriesTableView.tag = UIEmoticonChooserCategoryTableIdParent;
    [_categoriesScrollView addSubview:_childCategoriesTableView];
}

- (void)placeEmoticonsColumnView:(BOOL)nextToChild
{
    if(_emoticonsColumnView){
        [_emoticonsColumnView removeFromSuperview];
        _emoticonsColumnView = nil;
    }
    CGFloat left = _visibleSize.width;
    if(nextToChild){
        left = _visibleSize.width * 2.0f;
    }
    CGRect categoryTableVisibleRect = CGRectMake(left, 0.0f, _categoriesScrollView.frame.size.width, _visibleSize.height - _titleBarView.frame.size.height);
    _emoticonsColumnView = [[UIMultiColumnView alloc] initWithFrame:categoryTableVisibleRect];
    NSArray* categories = [DataProvider childCategoryObjectsByCategoryId:_currentParentCategoryId];
    _emoticonsColumnView.categoryObjectArray = categories;
    _emoticonsColumnView.visibleSize = _visibleSize;
    _emoticonsColumnView.parentCategoryId = _currentParentCategoryId;
    [_emoticonsColumnView layout];
    [_categoriesScrollView addSubview:_emoticonsColumnView];
}

#pragma mark TableManager delegate
#pragma mark Parent

- (void)tableView:(UITableView *)tableView didSelectParentCategory:(int)category_id
{
    LOG(@"Parent category %d was selected.", category_id);
    _currentParentCategoryId = category_id;
    int number_of_child = [DataProvider childCategoryCountByParentCategoryId:category_id];
    if(number_of_child == 0){
        
    }else{
        [ChildCategoriesTableManager instance].parentCategoryId = category_id;
        [self placeChildCategoryTableView];
        [self presentToChildCategoryList];
    }
}

#pragma mark Children

- (void)tableView:(UITableView *)tableView didSelectChildCategory:(int)category_id AtRow:(int)row
{
    LOG(@"CHild category %d was selected.", category_id);
    _currentChildCategoryId = category_id;
    _currentSelectedRow = row;
    if(_currentPage == UIEmoticonChooserCurrentPageIdChildCategory){
        [self placeEmoticonsColumnView:YES];
    }
    if(_currentPage == UIEmoticonChooserCurrentPageIdParentCategory){
        [self placeEmoticonsColumnView:NO];
    }
    [self presentToEmoticonsList];
}

#pragma mark present

- (BOOL)pagerShouldPresent
{
    _categoriesScrollView.scrollEnabled = NO;
    [CategoriesScrollManager instance].limitDirection = NO;
    return YES;
}

- (void)presentToParentCategoryList
{
    if([self pagerShouldPresent]){
        [_categoriesScrollView scrollRectToVisible:CGRectMake(0.0f, 0.0f, _visibleSize.width, _visibleSize.height) animated:YES];
        _currentPage = UIEmoticonChooserCurrentPageIdParentCategory;
    }
}

- (void)presentToChildCategoryList
{
    if([self pagerShouldPresent]){
        [_categoriesScrollView scrollRectToVisible:CGRectMake(_visibleSize.width, 0.0f, _visibleSize.width, _visibleSize.height) animated:YES];
        _currentPage = UIEmoticonChooserCurrentPageIdChildCategory;
    }
}

- (void)presentToEmoticonsList
{
    if([self pagerShouldPresent]){
        if(_currentPage == UIEmoticonChooserCurrentPageIdChildCategory){
            [_categoriesScrollView scrollRectToVisible:CGRectMake(_visibleSize.width * 2.0f, 0.0f, _visibleSize.width, _visibleSize.height) animated:YES];
        }
        if(_currentPage == UIEmoticonChooserCurrentPageIdParentCategory){
            [_categoriesScrollView scrollRectToVisible:CGRectMake(_visibleSize.width, 0.0f, _visibleSize.width, _visibleSize.height) animated:YES];
        }
        _currentPage = UIEmoticonChooserCurrentPageIdEmoticonsList;
    }
}

#pragma mark scrollview delegate

- (void)scrollView:(UIScrollView *)scrollView didPageChange:(int)page
{
    LOG(@"page was changed %d", page);
    _categoriesScrollView.contentOffset = CGPointMake(self.visibleSize.width * (page - 1), 0.0f);
    if(page == UIEmoticonChooserCurrentPageIdChildCategory){
        _categoriesScrollView.scrollEnabled = YES;
        [CategoriesScrollManager instance].limitDirection = YES;
    }
}

- (void)dealloc
{
    _categoriesScrollView.delegate = nil;
}

- (void)toggleDammyBackgroundView:(BOOL)show
{
    _dammyBackgroundView.hidden = !show;
}

@end
