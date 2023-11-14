//
//  HandBookViewController.h
//  ESDOInfo
//
//  Created by ITMU User on 4/3/14.
//  Copyright (c) 2014 ITMU User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HandBookViewController : UITableViewController <UIDocumentInteractionControllerDelegate>
@property (strong, nonatomic) UIDocumentInteractionController *controller;

@end
