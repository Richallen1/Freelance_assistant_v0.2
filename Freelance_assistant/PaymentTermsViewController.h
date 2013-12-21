//
//  PaymentTermsViewController.h
//  Freelance_assistant
//
//  Created by Rich Allen on 14/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaymentTermsViewController;

@protocol poverDelegate
@optional
-(void)dismissPopoverDelegateMethod:(PaymentTermsViewController *)sender;
@end

@interface PaymentTermsViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *paymentTermsField;
- (IBAction)doneButton:(id)sender;

@end
