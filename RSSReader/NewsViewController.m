//
//  NewsViewController.m
//  RSSReader
//
//  Created by Felix Hedlund on 17/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _newsTopicsIsHidden = false;
    _webView.hidden = true;
    _appDelegate = [UIApplication sharedApplication].delegate;
    /*
     newsTopicsIsHidden = false
     webView.hidden = true
     toolbar.hidden = true
     textView.hidden = true
     addHideButton()
     setTextViewSettings()
     appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
     textSwitch.addTarget(self, action: Selector("textSwitchClicked:"), forControlEvents: UIControlEvents.ValueChanged)
     textSwitch.setOn(SavedState.textOnly, animated: false)
     */
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
