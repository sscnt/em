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
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    LOG_SIZE([UIScreen screenSize]);
    
    [super viewDidLoad];
    
    //// Scroll View
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen screenRect]];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake([UIScreen width] * 4.0f, _scrollView.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.scrollEnabled = NO;
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0.0f, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    [self.view addSubview:_scrollView];
    
    
    //// Chooser
    _chooserView = [[UIEmoticonsChooserView alloc] initWithFrame:CGRectMake(10.0f + [UIScreen width], 30.0f, [UIScreen width] - 20.0f, [UIScreen height])];
    _chooserView.visibleSize = CGSizeMake([UIScreen width] - 20.0f, [UIScreen height] - 30.0f);
    if([UIDevice isIOS6]){
        [_chooserView setY:10.0f];
        _chooserView.visibleSize = CGSizeMake([UIScreen width] - 20.0f, [UIScreen height] - 30.0f);
    }
    _chooserView.delegate = self;
    [_scrollView addSubview:_chooserView];
}

- (void)viewDidAppear:(BOOL)animated
{

}

#pragma mark delegate

- (void)didSelectEmoticon:(int)emoticon_id
{
    LOG(@"Emoticon %d selected.", emoticon_id);
    [self presentToEditorView];
}

#pragma mark presenting

- (void)presentToSettingsView
{
    
}

- (void)presentToEditorView
{
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * 2.0f, 0.0f, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    _scrollView.scrollEnabled = YES;
    CGSize s = _scrollView.contentSize;
    LOG_SIZE(s);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [DataProvider cleanCaches];
}

- (void)dealloc
{
    _scrollView.delegate = nil;
    _chooserView.delegate = nil;
}

@end
