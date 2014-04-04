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
        [_titleBarView setTitle:NSLocalizedString(@"Emoticons", nil)];
        [self.view addSubview:_titleBarView];
        
        //// Category list scroll view
        _categoriesScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _categoriesScrollView.delegate = self;
        _categoriesScrollView.showsHorizontalScrollIndicator = NO;
        _categoriesScrollView.showsVerticalScrollIndicator = NO;
        _categoriesScrollView.pagingEnabled = YES;
        _categoriesScrollView.bounces = NO;
        _categoriesScrollView.scrollEnabled = NO;
        [self.view addSubview:_categoriesScrollView];
        
        //// Parent categories table view
        _parentCategoriesTableView = [[UITableView alloc] initWithFrame:frame];
        _parentCategoriesTableView.delegate = [ParentCategoriesTableManager instance];
        _parentCategoriesTableView.dataSource = [ParentCategoriesTableManager instance];
        [ParentCategoriesTableManager instance].delegate = self;
        _parentCategoriesTableView.tag = UIEmoticonChooserCategoryTableIdParent;
        [_categoriesScrollView addSubview:_parentCategoriesTableView];
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

#pragma mark TableManager delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOG(@"Cell was selected.");
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
