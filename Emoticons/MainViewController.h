//
//  ViewController.h
//  Emoticons
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBackgroundView.h"
#import "UIEmoticonsChooserView.h"

@interface MainViewController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView* _scrollView;
    UIEmoticonsChooserView* _chooserView;
}

- (void)presentToSettingsView;

@end
