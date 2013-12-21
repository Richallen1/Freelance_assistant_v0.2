//
//  EmailViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 14/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()

@end

@implementation EmailViewController
@synthesize emailField=_emailField;
- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (IBAction)doneButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:_emailField.text forKey:@"User_Name"];
    [defaults synchronize];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Stored" message:@"Your details have been saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}
@end
