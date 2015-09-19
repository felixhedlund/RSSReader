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
    //http://www.dn.se/nyheter/m/rss/
    
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
    //self.clearsSelectionOnViewWillAppear = NO;

}

- (void) parsingWasFinished{
    [_xmlParser.arrParsedData removeObjectAtIndex:0];
//    for (NSMutableDictionary* dictionary in _xmlParser.arrParsedData) {
//        NSLog([dictionary objectForKey:@"title"]);
//        NSLog([dictionary objectForKey:@"link"]);
//    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //[popController.popoverPresentationController]
    [self presentViewController:_popController animated:true completion:nil];
    
    _popController.popoverPresentationController.barButtonItem = _rssButton;
    _popController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    _popController.preferredContentSize = CGSizeMake(270, 80);
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

/*
 popoverViewController?.popoverPresentationController?.barButtonItem = pubDateButtonItem
 popoverViewController?.popoverPresentationController?.permittedArrowDirections = .Any
 popoverViewController?.preferredContentSize = CGSizeMake(200.0, 80.0)
 
 popoverViewController?.lblMessage.text = "Publish Date:\n\(publishDate)"
 */

//- (IBAction)returnRSSImageToInitialState:(id)sender{
//    _rssImage.image = [UIImage imageNamed:@"rss"];
//}


//@IBAction func showPublishDate(sender: AnyObject) {
//    var popoverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idPopoverViewController") as? PopoverViewController
//    
//    popoverViewController?.modalPresentationStyle = UIModalPresentationStyle.Popover
//    
//    popoverViewController?.popoverPresentationController?.delegate = self
//    
//    self.presentViewController(popoverViewController!, animated: true, completion: nil)
//    
//}

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
     return cell;
 }

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dictionary = [_xmlParser.arrParsedData objectAtIndex:indexPath.row];
    NSString* newsLink = [dictionary objectForKey:@"link"];
    //NSLog(@"%@", newsLink);
    NewsViewController* newsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle: nil]        instantiateViewControllerWithIdentifier:@"idNewsViewController"];
    newsViewController.newsURL = [[NSURL alloc] initWithString:newsLink];
    [self showDetailViewController:newsViewController sender:self];
    [newsViewController hideButtonPressed:nil];
}

/*
 override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 let dictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
 let newsLink = dictionary["link"]
 
 let newsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idNewsViewController") as! NewsViewController
 
 newsViewController.newsURL = NSURL(string: newsLink!)
 newsViewController.newsDescription = dictionary["description"]
 showDetailViewController(newsViewController, sender: self)
 
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
