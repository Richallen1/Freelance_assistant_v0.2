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
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];}

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
