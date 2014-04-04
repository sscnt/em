//
//  UIEmoticonsChooserView.h
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITitleBarView.h"


typedef NS_ENUM(NSInteger, UIEmoticonChooserCategoryTableId){
    UIEmoticonChooserCategoryTableIdParent = 1,
    UIEmoticonChooserCategoryTableIdChildren
};


@interface UIEmoticonsChooserView : UIView <UIScrollViewDelegate, TableManagerDelegate>
{
    UIView* _dammyBackgroundView;
    UITitleBarView* _titleBarView;
    UIScrollView* _categoriesScrollView;
    UITableView* _parentCategoriesTableView;
    UITableView* _childCategoriesTableView;
}

@property (nonatomic, strong) UIView* view;
@property (nonatomic, assign) CGSize visibleSize;

- (void)toggleDammyBackgroundView:(BOOL)show;

@end
