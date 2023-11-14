//
//  HandBookDetailViewController.m
//  ESDOInfo
//
//  Created by ITMU User on 4/3/14.
//  Copyright (c) 2014 ITMU User. All rights reserved.
//

#import "HandBookDetailViewController.h"

@interface HandBookDetailViewController ()

@end

@implementation HandBookDetailViewController
@synthesize BookWebView;
@synthesize link;
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){}
        else
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.BookWebView.delegate = self;
// Set Button
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    UIBarButtonItem *downloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(download:)];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    
    
    NSArray *ButtonArray = [[NSArray alloc] initWithObjects:refreshButton,downloadButton, nil];
    
    self.navigationItem.rightBarButtonItems = ButtonArray;
    
 // Display UIWebView
    
    NSString *urlString = [NSString stringWithFormat:@"http://m.dsd.gov.hk/mfmrs/handbook/%@.pdf", link];
    
    NSURL * url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.BookWebView loadRequest:request];
        [self.BookWebView setScalesPageToFit:YES];
     
    }
   }
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [[UIApplication sharedApplication] openURL:request.URL];
        return false;
    }
    
    return true;
}
- (IBAction)refresh:(id)sender
{
    [self.BookWebView reload];
}


- (IBAction)download:(id)sender
{    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
    
    NSString *urlString = [NSString stringWithFormat:@"http://m.dsd.gov.hk/mfmrs/handbook/%@.pdf", link];
    
    
    NSURL * url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //   NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent]stringByAppendingPathComponent:@"ESDO_Information.pdf"]];
    //       NSString *filePath = [resourceDocPath stringByAppendingPathComponent:@"ESDO_Information.pdf"];
    
    
    //Download
    //   NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    
    NSURL *requestedURL = [request URL];
    // ...Check if the URL points to a file you're looking for...
    // Then load the file
    NSData *fileData = [[NSData alloc] initWithContentsOfURL:requestedURL];
    // Get the path to the App's Documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0 ]; // Get documents folder
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[requestedURL lastPathComponent]];
    [fileData writeToFile:path atomically:YES];
    //   NSString *filePath = [NSString stringWithFormat:@"%@%@", documentsDirectory, [requestedURL lastPathComponent]];
    //                    [fileData writeToFile:filePath atomically:YES];
    
    // NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[requestedURL lastPathComponent]];
    
    //[fileData writeToFile:filePath atomically:YES];
    
    
    // NSString *URL2 = [NSString stringWithFormat: documentsDirectory, [requestedURL lastPathComponent]];
    NSURL *URL = [NSURL fileURLWithPath:path];
    
    if (URL) {
        
        self.controller = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        self.controller.delegate = self;
        self.controller.UTI = @"com.adobe.pdf";
        
        [self.controller presentOptionsMenuFromBarButtonItem:(UIBarButtonItem*)sender animated:YES];
        
        
    }
    
    

    
}
else{if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    //Download the PDF
    NSString *urlString = [NSString stringWithFormat:@"http://m.dsd.gov.hk/mfmrs/handbook/%@.pdf", link];
    
    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    
    
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent]stringByAppendingPathComponent:@"Documents"]];
    
    NSString *filePath = [resourceDocPath stringByAppendingPathComponent:@"Handbook.pdf"]; // ori:handbook
    
    [pdfData writeToFile:filePath atomically:YES];
    
    NSURL *URL = [NSURL fileURLWithPath:filePath];
    
    if (URL) {
        
        self.controller = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        self.controller.delegate = self;
        self.controller.UTI = @"com.adobe.pdf";
        
        [self.controller presentOptionsMenuFromBarButtonItem:(UIBarButtonItem*)sender animated:YES];
        
        
    }}}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (UIViewController *)

documentInteractionControllerViewControllerForPreview:

(UIDocumentInteractionController *)controller

{
    
    return self;
    
}



- (UIView *)

documentInteractionControllerViewForPreview:

(UIDocumentInteractionController *)controller

{
    
    return self.view;
    
}



- (CGRect)

documentInteractionControllerRectForPreview:

(UIDocumentInteractionController *)controller

{
    
    return self.view.frame;
    
}
@end
