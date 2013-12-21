//
//  SettingsViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 14/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"
#import "UserInfoViewController.h"
#import "PaymentTermsViewController.h"

@interface SettingsViewController ()<poverDelegate>


@property (nonatomic, strong) UIPopoverController *popoverController;
@end

@implementation SettingsViewController
@synthesize userNameLabel=_userNameLabel;
@synthesize userAddressLabel=_userAddressLabel;
@synthesize userEmailLabel=_userEmailLabel;
@synthesize logoLabel=_logoLabel;
@synthesize paymentLabel=_paymentLabel;
@synthesize bankDetialsLabel=_bankDetialsLabel;
@synthesize popoverController;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    _userNameLabel.text  = [defaults objectForKey:@"User_Name"];
    _userAddressLabel.text = [defaults objectForKey:@"User_Address_1"];
    _userEmailLabel.text = [defaults objectForKey:@"User_Email"];
    _logoLabel.text = @"";
    if ([defaults objectForKey:@"inv_term_period"] != NULL) {
        NSString *paymentTerms = [NSString stringWithFormat:@"%@ Days",[defaults objectForKey:@"inv_term_period"]];
        _paymentLabel.text = paymentTerms;
    }
    if ([defaults objectForKey:@"Bank_Details_Status"]) {
        _bankDetialsLabel.text = @"Detials Stored";
    }
    _bankDetialsLabel.text = @"None Stored";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissPopoverDelegateMethod:(PaymentTermsViewController *)sender
{
    [popoverController dismissPopoverAnimated:YES];
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"payment_terms_segue"]) {
        if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
            UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *)segue;
            [self.popoverController dismissPopoverAnimated:YES];
            self.popoverController = popoverSegue.popoverController;
        }
        //[segue.destinationViewController setDelegate:self];
    }
}
@end
