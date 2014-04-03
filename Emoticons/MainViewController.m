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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //// Scroll View
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake([UIScreen width] * 4.0f, [UIScreen height]);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.userInteractionEnabled = NO;
    _scrollView.contentOffset = CGPointMake([UIScreen width], 0.0f);
    [self.view addSubview:_scrollView];
    
    //// Chooser
    _chooserView = [[UIEmoticonsChooserView alloc] initWithFrame:CGRectMake(10.0f + [UIScreen width], 30.0f, [UIScreen width] - 20.0f, [UIScreen height])];
    if([UIDevice isIOS6]){
        [_chooserView setY:10.0f];
    }
    [_scrollView addSubview:_chooserView];
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
