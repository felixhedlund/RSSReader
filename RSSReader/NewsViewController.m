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
    // Do any additional setup after loading the view.
    _newsTopicsIsHidden = false;
    _webView.hidden = true;
    [self addHideButton];
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
    CGFloat imageSideSize = _hideContentView.frame.size.width;
    _hideImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageSideSize, imageSideSize)];
    _hideImage.image = [UIImage imageNamed:@"Arrow-left"];
    [_hideContentView addSubview:_hideImage];
    
    UIButton* hideButton = [[UIButton alloc] initWithFrame:_hideImage.frame];
    [hideButton addTarget:self action:@selector(hideButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_hideContentView addSubview:hideButton];
    
    /*
     hideImage = UIImageView(frame: CGRectMake(0, 0, imageWidth, imageHeight))
     hideImage.image = UIImage(named: "Arrow-left")
     hideContentView.addSubview(hideImage)
     
     var hideButton = UIButton(frame: hideImage.frame)
     hideButton.addTarget(self, action: Selector("hideButtonPressed:"), forControlEvents: .TouchUpInside)
     
     hideContentView.addSubview(hideButton)
     
     self.view.addSubview(hideContentView)
     */
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
    
   /*
    if(newsTopicsIsHidden!){
    newsTopicsIsHidden = false
    hideImage.image = UIImage(named: "Arrow-left")
    appDelegate.containerViewController.showNewsTopics()
    }else{
    newsTopicsIsHidden = true
    hideImage.image = UIImage(named: "Arrow-right")
    appDelegate.containerViewController.hideNewsTopics()
    }
    */
    
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
