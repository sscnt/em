//
//  UIEmoticonsChooserView.h
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITitleBarView.h"

@interface UIEmoticonsChooserView : UIView <UIScrollViewDelegate>
{
    UIView* _dammyBackgroundView;
    UITitleBarView* _titleBarView;
    UIScrollView* _categoriesScrollView;
}

@property (nonatomic, strong) UIView* view;
@property (nonatomic, assign) CGSize visibleSize;

- (void)toggleDammyBackgroundView:(BOOL)show;

@end
