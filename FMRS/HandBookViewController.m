//
//  HandBookViewController.m
//  ESDOInfo
//
//  Created by ITMU User on 4/3/14.
//  Copyright (c) 2014 ITMU User. All rights reserved.
//

#import "HandBookViewController.h"
#import "HandBookDetailViewController.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
@interface HandBookViewController ()


@end

@implementation HandBookViewController
NSArray *bookList;
NSArray *subBookList;
NSArray *linkList;

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

   //
  //  self.edgesForExtendedLayout = UIRectEdgeAll;
  //  self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f);
    
  	bookList = [NSArray arrayWithObjects:@"Cover", @"Table of Contents", @"Revision Control Sheet", @"Distribution List", @"Glossary", @"Chapter 1", @"Chapter 2", @"Appendix 01", @"Appendix 02",@"Appendix 03",@"Appendix 04", nil];
    
    subBookList = [NSArray arrayWithObjects:@"0-Cover", @"1-Table of Contents", @"2-Revision Control Sheet", @"3-Distribution List", @"4-Glossary", @"5-Chapter 1", @"6-Chapter 2", @"7-Appendix 01", @"8-Appendix 02",@"9-Appendix 03",@"10-Appendix 04", nil];
    linkList = [NSArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"",@"",@"",nil];
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

    return [bookList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [bookList objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [linkList objectAtIndex:indexPath.row];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")){
    
    NSString *urlString = [NSString stringWithFormat:@"http://m.dsd.gov.hk/mfmrs/handbook/%@.pdf", [subBookList objectAtIndex:indexPath.row]];
    
    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    
    
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent]stringByAppendingPathComponent:@"Documents"]];
    
    NSString *filePath = [resourceDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",[subBookList objectAtIndex:indexPath.row]]];
    
    [pdfData writeToFile:filePath atomically:YES];
    
    NSURL *URL = [NSURL fileURLWithPath:filePath];
    
    if (URL) {
        
        self.controller = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        [self.controller setDelegate : self];
        
        [self.controller presentPreviewAnimated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    }
    
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HandBookDetailViewController *destViewController = segue.destinationViewController;
        destViewController.link = [subBookList objectAtIndex:indexPath.row];
    }}
}


@end
