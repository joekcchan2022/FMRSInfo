//
//  InformationDetailViewController.m
//  ESDOInfo
//
//  Created by ITMU User on 5/3/14.
//  Copyright (c) 2014 ITMU User. All rights reserved.
//

#import "InformationDetailViewController.h"

@interface InformationDetailViewController ()
//@interface SomethingController ()
@end

@implementation InformationDetailViewController
@synthesize infoWebView;
@synthesize link;
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
      self.infoWebView.delegate = self;
    
    // Set Button
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {[super viewDidLoad];
    UIBarButtonItem *ActionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(download:)];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    
    
    NSArray *ButtonArray = [[NSArray alloc] initWithObjects:refreshButton,ActionButton, nil];
    
    self.navigationItem.rightBarButtonItems = ButtonArray;
    
    
    
        
        
        
        
	
    // Display UIWebView
    
    NSString *urlString = [NSString stringWithFormat:@"http://m.dsd.gov.hk/mfmrs/others/%@.pdf", link];
    
    NSURL * url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.infoWebView loadRequest:request];
        //[self.infoWebView setDelegate];
    [self.infoWebView setScalesPageToFit:YES];
    
        
    
     }
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        [self dismissViewControllerAnimated:YES completion:Nil];}
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
    [self.infoWebView reload];
}


- (IBAction)download:(id)sender
{
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                        message:@"This function is currently not available"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
         */
        // Get the URL of the loaded ressource

    
/*
        NSURL *theRessourcesURL = [[self.infoWebView  request] URL];
        NSString *fileExtension = [theRessourcesURL pathExtension];
        
        if ([fileExtension isEqualToString:@"pdf"]) {
            // Get the filename of the loaded ressource form the UIWebView's request URL
            NSString *filename = [theRessourcesURL lastPathComponent];
            NSLog(@"Filename: %@", filename);
            // Get the path to the App's Documents directory
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 
                                                                 NSUserDomainMask, YES);
            
            NSString *documentsDirectory = [paths objectAtIndex:0];
           // NSString *docPath = [self documentsDirectoryPath];
            // Combine the filename and the path to the documents dir into the full path
            NSString *pathToDownloadTo = [NSString stringWithFormat:@"%@/%@", documentsDirectory, filename];
            
            
            // Load the file from the remote server
            NSData *tmp = [NSData dataWithContentsOfURL:theRessourcesURL];
            // Save the loaded data if loaded successfully
            if (tmp != nil) {
                NSError *error = nil;
                // Write the contents of our tmp object into a file
                [tmp writeToFile:pathToDownloadTo options:NSDataWritingAtomic error:&error];
                if (error != nil) {
                    NSLog(@"Failed to save the file: %@", [error description]);
                } else {
                    // Display an UIAlertView that shows the users we saved the file :)
                    UIAlertView *filenameAlert = [[UIAlertView alloc] initWithTitle:@"File saved" message:[NSString stringWithFormat:@"The file %@ has been saved.", filename] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [filenameAlert show];
                    
                }
            } else {
                // File could notbe loaded -> handle errors
            }
        } else {
            // File type not supported
        }
   
    */
        NSString *urlString = [NSString stringWithFormat:@"http://m.dsd.gov.hk/mfmrs/others/%@.pdf", link];
        
        
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
    NSString *urlString = [NSString stringWithFormat:@"http://m.dsd.gov.hk/mfmrs/others/%@.pdf", link];
    
    
    
    
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent]stringByAppendingPathComponent:@"Documents"]];
     NSString *filePath = [resourceDocPath stringByAppendingPathComponent:@"FMRS_Others.pdf"];
        
       
        //Download
    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    
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


- (NSString *)documentsDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return documentsDirectoryPath;
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
