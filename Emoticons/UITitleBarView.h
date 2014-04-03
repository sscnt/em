//
//  UITitleBarView.h
//  Emoticons
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITitleBarView : UIView
{
    UILabel* _titleLabel;
}

- (void)setTitle:(NSString*)title;

@end
