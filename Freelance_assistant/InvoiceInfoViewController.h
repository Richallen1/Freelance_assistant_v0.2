//
//  InvoiceInfoViewController.h
//  Freelance_assistant
//
//  Created by Rich Allen on 17/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Invoice.h"

@interface InvoiceInfoViewController : UIViewController

@property (strong, nonatomic)Invoice *invoiceAtIndexPath;

@property (strong, nonatomic)NSString *test;

@end
