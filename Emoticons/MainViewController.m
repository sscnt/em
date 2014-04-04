//
//  ViewController.m
//  Emoticons
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)loadView
{
    self.view = [[UIBackgroundView alloc] initWithFrame:[UIScreen screenRect]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //// Scroll View
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen screenRect]];
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake([UIScreen width] * 4.0f, [UIScreen height]);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollEnabled = NO;
    _scrollView.contentOffset = CGPointMake([UIScreen width], 0.0f);
    [self.view addSubview:_scrollView];
    
    //// Chooser
    _chooserView = [[UIEmoticonsChooserView alloc] initWithFrame:CGRectMake(10.0f + [UIScreen width], 10.0f, [UIScreen width] - 20.0f, [UIScreen height])];
    _chooserView.visibleSize = CGSizeMake([UIScreen width] - 20.0f, [UIScreen height] - 30.0f);
    if([UIDevice isIOS6]){
        [_chooserView setY:10.0f];
        _chooserView.visibleSize = CGSizeMake([UIScreen width] - 20.0f, [UIScreen height] - 30.0f);
    }
    [_scrollView addSubview:_chooserView];
}

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)presentToSettingsView
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    _scrollView.delegate = nil;
}

@end
