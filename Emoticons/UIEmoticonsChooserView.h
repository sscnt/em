//
//  UIEmoticonsChooserView.h
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITitleBarView.h"
#import "UITitleBarButton.h"
#import "UIMultiColumnView.h"
#import "ParentCategoriesTableManager.h"
#import "ChildCategoriesTableManager.h"


typedef NS_ENUM(NSInteger, UIEmoticonChooserCategoryTableId){
    UIEmoticonChooserCategoryTableIdParent = 1,
    UIEmoticonChooserCategoryTableIdChildren
};

typedef NS_ENUM(NSInteger, UIEmoticonChooserCurrentPageId){
    UIEmoticonChooserCurrentPageIdParentCategory = 1,
    UIEmoticonChooserCurrentPageIdChildCategory,
    UIEmoticonChooserCurrentPageIdEmoticonsList
};

@interface UIEmoticonsChooserView : UIView <CategoriesScrollManagerDelegate, TableManagerDelegate>
{
    UIEmoticonChooserCurrentPageId _currentPage;
    UIView* _dammyBackgroundView;
    UITitleBarView* _titleBarView;
    UIScrollView* _categoriesScrollView;
    UITableView* _parentCategoriesTableView;
    UITableView* _childCategoriesTableView;
    UIMultiColumnView* _emoticonsColumnView;
    int _currentParentCategoryId;
    int _currentChildCategoryId;
    int _currentSelectedRow;
}

@property (nonatomic, strong) UITitleBarButton* backButton;
@property (nonatomic, strong) UIView* view;
@property (nonatomic, assign) CGSize visibleSize;

- (void)toggleDammyBackgroundView:(BOOL)show;

- (void)placeChildCategoryTableView;
- (void)placeEmoticonsColumnView:(BOOL)nextToChild;

- (BOOL)pagerShouldPresent;
- (void)pageWillBeBack;
- (void)presentToParentCategoryList;
- (void)presentToChildCategoryList;
- (void)presentToEmoticonsList;
- (void)presentToPreviousPage;

- (void)scrollView:(UIScrollView *)scrollView didPageChange:(int)page;

- (void)backButtonDidTouch:(UITitleBarButton*)button;

@end
