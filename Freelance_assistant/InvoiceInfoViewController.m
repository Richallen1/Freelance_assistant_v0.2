//
//  InvoiceInfoViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 17/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "InvoiceInfoViewController.h"

@interface InvoiceInfoViewController ()

@end

@implementation InvoiceInfoViewController
@synthesize invoiceAtIndexPath=_invoiceAtIndexPath;
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
    [super viewDidLoad];
    NSLog(@"%@", _invoiceAtIndexPath.date);


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
