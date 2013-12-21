//
//  BankDetailsViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 14/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "BankDetailsViewController.h"

@interface BankDetailsViewController ()

@end

@implementation BankDetailsViewController
@synthesize accountNumber=_accountNumber;
@synthesize sortCode=_sortCode;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"Bank_Details_Status"]) {
        _accountNumber.text = [defaults objectForKey:@"User_Account_Number"];
        _sortCode.text = [defaults objectForKey:@"User_Sort_Code"];
    }
    else
    {
        _accountNumber.text = @"";
        _sortCode.text = @"";
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (IBAction)doneButton:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_accountNumber.text forKey:@"User_Account_Number"];
    [defaults setObject:_sortCode.text forKey:@"User_Sort_Code"];
    [defaults synchronize];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Stored" message:@"Your details have been saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}
@end
