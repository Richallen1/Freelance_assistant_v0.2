//
//  PaymentTermsViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 14/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "PaymentTermsViewController.h"

@interface PaymentTermsViewController ()

@end

@implementation PaymentTermsViewController
@synthesize paymentTermsField=_paymentTermsField;

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (IBAction)doneButton:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_paymentTermsField.text forKey:@"inv_term_period"];
    [defaults synchronize];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Stored" message:@"Your details have been saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    
   
}
@end
