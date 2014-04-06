//
//  UITitleBarView.h
//  Emoticons
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITitleBarButton.h"

@interface UITitleBarView : UIView
{
    UILabel* _titleLabel;
    UILabel* _subtitleLabel;
}

@property (nonatomic, assign) BOOL leftButtonAnimationStarted;
@property (nonatomic, assign) BOOL rightButtonAnimationStarted;
@property (nonatomic, weak) UITitleBarButton* leftButton;
@property (nonatomic, weak) UITitleBarButton* rightButton;

- (void)setTitle:(NSString*)title;
- (void)setSubtitle:(NSString*)title;
- (void)setSubtitle:(NSString*)title withDuration:(CGFloat)duration;

- (void)addButtonToLeft:(UITitleBarButton*)button;
- (void)addButtonToRight:(UITitleBarButton*)button;

- (void)hideRightButton;
- (void)hideRightButtonWithDuration:(CGFloat)duration;
- (void)hideLeftButton;
- (void)hideLeftButtonWithDuration:(CGFloat)duration;

- (void)showRightButton;
- (void)showRightButtonWithDuration:(CGFloat)duration;
- (void)showLeftButton;
- (void)showLeftButtonWithDuration:(CGFloat)duration;

@end
