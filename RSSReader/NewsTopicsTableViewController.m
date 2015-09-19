//
//  NewsTopicsTableViewController.m
//  RSSReader
//
//  Created by Felix Hedlund on 17/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import "NewsTopicsTableViewController.h"
#import "NewsViewController.h"
#import "SavedState.h"
#import "PopoverViewController.h"
@class SavedState;
@class PopoverViewController;
@interface NewsTopicsTableViewController ()

@end

@implementation NewsTopicsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topicsBackground-highlight.png"]]];
    
    [self addBarButton];
    SavedState* savedState = [SavedState sharedInstance];
    NSURL* url;
    if (!savedState.rssURL) {
        savedState.rssURL = [[NSURL alloc] initWithString:@"http://www.aftonbladet.se/rss.xml"];
        [savedState saveState];
    }
    url = savedState.rssURL;
    _xmlParser = [[XMLParser alloc] init];
    _xmlParser.delegate = self;
    [_xmlParser startParsingWithContentsOfURL:url];

}

- (void) parsingWasFinished{
    [_xmlParser.arrParsedData removeObjectAtIndex:0];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) addBarButton{
    CGRect frameimg = CGRectMake(0, 0, 35, 35);
    UIButton *barButton = [[UIButton alloc] initWithFrame:frameimg];
    [barButton setBackgroundImage:[UIImage imageNamed:@"rss"] forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"rss-dark"] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(showRSSPopover:)
        forControlEvents:UIControlEventTouchUpInside];
    [barButton setShowsTouchWhenHighlighted:YES];
    
    _rssButton =[[UIBarButtonItem alloc] initWithCustomView:barButton];
    self.navigationItem.leftBarButtonItem=_rssButton;
}

- (IBAction)showRSSPopover:(id)sender{
    _popController = [[UIStoryboard storyboardWithName:@"Main" bundle: nil]        instantiateViewControllerWithIdentifier:@"idPopoverViewController"];
    _popController.modalPresentationStyle = UIModalPresentationPopover;
    _popController.popoverPresentationController.delegate = self;
    [self presentViewController:_popController animated:true completion:nil];
    
    _popController.popoverPresentationController.barButtonItem = _rssButton;
    _popController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    _popController.preferredContentSize = CGSizeMake(280, 60);
    _popController.rssTextField.placeholder = [SavedState sharedInstance].rssURL.absoluteString;
    _popController.rssTextField.delegate = self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSURL* url = [NSURL URLWithString:textField.text];
    if(url && url.scheme && url.host){
        [_popController dismissViewControllerAnimated:true completion:nil];
        SavedState* savedState = [SavedState sharedInstance];
        savedState.rssURL = url;
        [savedState saveState];
        
        _xmlParser = [[XMLParser alloc] init];
        _xmlParser.delegate = self;
        [_xmlParser startParsingWithContentsOfURL:url];
    }
    
    return true;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

- (void) returnToOriginalURL{
    SavedState* savedState = [SavedState sharedInstance];
    savedState.rssURL = [[NSURL alloc] initWithString:@"http://www.aftonbladet.se/rss.xml"];
    [savedState saveState];
    
    NSURL* url = savedState.rssURL;
    _xmlParser = [[XMLParser alloc] init];
    _xmlParser.delegate = self;
    [_xmlParser startParsingWithContentsOfURL:url];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _xmlParser.arrParsedData.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idNewsCell" forIndexPath:indexPath];
 
     NSDictionary* currentDictionary = [_xmlParser.arrParsedData objectAtIndex:indexPath.row];
     cell.textLabel.text = [currentDictionary objectForKey:@"title"];
     [cell setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"topicsBackground.png"]]];
     cell.selectedBackgroundView = [UIView new];
     cell.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topicsBackground-highlight.png"]];     
     
     return cell;
 }

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_xmlParser.arrParsedData.count < 1) {
        //Easy fix for an URL that is a valid link but invalid RSS-feed, XML parser does not call "parserDidEndDocument" for these links.
        [self returnToOriginalURL];
    }else{
        NSDictionary* dictionary = [_xmlParser.arrParsedData objectAtIndex:indexPath.row];
        NSString* newsLink = [dictionary objectForKey:@"link"];
        NewsViewController* newsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle: nil]        instantiateViewControllerWithIdentifier:@"idNewsViewController"];
        newsViewController.newsURL = [[NSURL alloc] initWithString:newsLink];
        [self showDetailViewController:newsViewController sender:self];
        [newsViewController hideButtonPressed:nil];
    }
    
}

@end
