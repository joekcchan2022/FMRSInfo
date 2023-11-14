//
//  RosterViewController.m
//  ESDOInfo
//
//  Created by ITMU User on 3/3/14.
//  Copyright (c) 2014 ITMU User. All rights reserved.
//

#import "RosterViewController.h"
#import "RosterDetailViewController.h"

@interface RosterViewController ()

@end

@implementation RosterViewController
NSArray *rosterList;
NSArray *subRosterList;
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
  //  self.edgesForExtendedLayout = UIRectEdgeAll;
  //  self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f);

     rosterList = [NSArray arrayWithObjects:@"Roster - April", @"Roster - May", @"Roster - June", @"Roster - July", @"Roster - August", @"Roster - September", @"Roster - October",@"Roster - November",nil];
    
    subRosterList = [NSArray arrayWithObjects:@"FMRS_Roster_April", @"FMRS_Roster_May", @"FMRS_Roster_June", @"FMRS_Roster_July", @"FMRS_Roster_August", @"FMRS_Roster_September", @"FMRS_Roster_October",@"FMRS_Roster_November", nil];

   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(navigationType ==  UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    else
        return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

   
    return [rosterList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [rosterList objectAtIndex:indexPath.row];
   cell.detailTextLabel.text = [subRosterList objectAtIndex:indexPath.row];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")){//http://m.dsd.gov.hk/mesdo/esdotel/%@.pdf"
    NSString *urlString = [NSString stringWithFormat:@"http://m.dsd.gov.hk/mfmrs/roster/%@.pdf", [subRosterList objectAtIndex:indexPath.row]];
    
    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    
    
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent]stringByAppendingPathComponent:@"Documents"]];
    
    
    NSString *filePath = [resourceDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",[rosterList objectAtIndex:indexPath.row]]];
    
    [pdfData writeToFile:filePath atomically:YES];
    
    NSURL *URL = [NSURL fileURLWithPath:filePath];
    if (URL) {
        
        self.controller = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        [self.controller setDelegate : self];
        
        [self.controller presentPreviewAnimated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }}
    
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RosterDetailViewController *destViewController = segue.destinationViewController;
        destViewController.link = [subRosterList objectAtIndex:indexPath.row];
    }}
}




@end
