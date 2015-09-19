//
//  ContainerViewController.m
//  RSSReader
//
//  Created by Felix Hedlund on 16/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.maximumColumnWidth = self.viewController.maximumPrimaryColumnWidth;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setEmbeddedViewController:(UISplitViewController*)splitViewController{
    
    if (splitViewController != nil) {
        _viewController = splitViewController;
        [self addChildViewController:_viewController];
        [self.view addSubview:_viewController.view];
        [_viewController didMoveToParentViewController:self];
        [self setOverrideTraitCollection:[UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular] forChildViewController:_viewController];
    }
    
}

-(void) hideNewsTopics{
    
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations: ^{self.viewController.maximumPrimaryColumnWidth = 0;} completion: ^(BOOL finished){}];
}

-(void) showNewsTopics{
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations: ^{self.viewController.maximumPrimaryColumnWidth = self.maximumColumnWidth;} completion: ^(BOOL finished){}];
}

@end
