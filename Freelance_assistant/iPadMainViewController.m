//
//  iPadMainViewController.m
//  iPadSlideDemo
//
//  Created by Rich Allen on 05/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "iPadMainViewController.h"
#import "SWRevealViewController.h"


@interface iPadMainViewController ()

@end

@implementation iPadMainViewController

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
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"Rich Allen" forKey:@"User_Name"];
    [defaults setObject:@"27 Ecton Road" forKey:@"User_Address_1"];
    [defaults setObject:@"KT15 1UE" forKey:@"User_Address_2"];
    //[defaults setObject:@"Payment due in 30 days" forKey:@"User_Notes"];
    [defaults setObject:@"0000000000000" forKey:@"User_Account_Number"];
    [defaults setObject:@"00-00-00" forKey:@"User_Sort_Code"];
    [defaults setObject:@"111 2222 33" forKey:@"User_VAT"];
    [defaults setObject:@"30" forKey:@"inv_term_period"];
    
    [defaults synchronize];
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)invoicesDue
{
    //Search for all invoices that have a due date priror to todays date
    
}

-(void) upcomingCalendarEvents
{

}
@end
