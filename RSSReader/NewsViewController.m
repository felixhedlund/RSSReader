//
//  NewsViewController.m
//  RSSReader
//
//  Created by Felix Hedlund on 17/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import "NewsViewController.h"
#import "AppDelegate.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _newsTopicsIsHidden = false;
    _webView.hidden = true;
    [self addHideButton];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showWebContent];
    [self.view bringSubviewToFront:_hideContentView];
}

- (void) showWebContent{
    if (_newsURL != nil) {
        NSURLRequest* request = [[NSURLRequest alloc] initWithURL:_newsURL];
        [_webView loadRequest:request];
        
        if (_webView.hidden) {
            _webView.hidden = false;
        }
    }
}

- (void) addHideButton{
    _hideImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _hideContentView.frame.size.width, _hideContentView.frame.size.height)];
    _hideImage.image = [UIImage imageNamed:@"Arrow-left"];
    [_hideContentView addSubview:_hideImage];
    
    UIButton* hideButton = [[UIButton alloc] initWithFrame:_hideImage.frame];
    [hideButton addTarget:self action:@selector(hideButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_hideContentView addSubview:hideButton];
}

- (void) hideButtonPressed:(UIButton *) sender {
    if (_newsTopicsIsHidden) {
        _newsTopicsIsHidden = false;
        _hideImage.image = [UIImage imageNamed:@"Arrow-left"];
        [[(AppDelegate *)[[UIApplication sharedApplication] delegate] self].containerViewController showNewsTopics];
        
    }else{
        _newsTopicsIsHidden = true;
        _hideImage.image = [UIImage imageNamed:@"Arrow-right"];
        [[(AppDelegate *)[[UIApplication sharedApplication] delegate] self].containerViewController hideNewsTopics];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
