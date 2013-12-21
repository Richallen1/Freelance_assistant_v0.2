//
//  UserInfoViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 14/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController
@synthesize userFirstName=_userFirstName;
@synthesize userSurname=_userSurname;

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

- (IBAction)donButton:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *nameStr = [_userFirstName.text stringByAppendingString:_userSurname.text];
    [defaults setObject:nameStr forKey:@"User_Name"];
    [defaults synchronize];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Stored" message:@"Your details have been saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}
@end
