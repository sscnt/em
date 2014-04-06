//
//  UITitleBarButton.h
//  Emoticons
//
//  Created by SSC on 2014/04/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UITitleBarButtonType){
    UITitleBarButtonTypeSettings = 1,
    UITitleBarButtonTypeBack
};

@interface UITitleBarButton : UIButton
{
    UITitleBarButtonType _type;
}

- (id)initWithType:(UITitleBarButtonType)type;

@end
