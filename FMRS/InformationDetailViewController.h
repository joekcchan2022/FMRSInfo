//
//  InformationDetailViewController.h
//  ESDOInfo
//
//  Created by ITMU User on 5/3/14.
//  Copyright (c) 2014 ITMU User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationDetailViewController : UIViewController <UIWebViewDelegate>

//@interface SomethingController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) NSString * link;
@property (strong, nonatomic) UIDocumentInteractionController *controller;

@property (strong, nonatomic) IBOutlet UIWebView * infoWebView;


@end
