//
//  iPadMainViewController.m
//  iPadSlideDemo
//
//  Created by Rich Allen on 05/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "iPadMainViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "Invoice.h"
#import "Client.h"

@interface iPadMainViewController ()
{
    NSManagedObjectContext *context;
    NSMutableArray *invoicesDue;
}
@end

@implementation iPadMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
    
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
    [defaults setObject:@"rich.allenlx@gmail.com" forKey:@"User_Email"];
    [defaults setObject:@"" forKey:@"logo"];
    
    [defaults synchronize];
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self invoicesDue];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)invoicesDue
{
   invoicesDue = [[NSMutableArray alloc]init];
    
    //Search for all invoices that have a due date priror to todays date
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int invTerms = 30;
    
    if ([defaults objectForKey:@"inv_term_period"] == nil) {
        invTerms = 30;
    }
    else
    {
        invTerms = [[defaults objectForKey:@"inv_term_period"] intValue];
    }
    
    //Get Date Info
    NSDate *now = [[NSDate alloc] init];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd/MM/yyyy"];
 
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Invoice"];
    NSError *error = nil;
    NSArray *invoices = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject *invoice in invoices) {
        NSString *dateString = [invoice valueForKey:@"date"];
        NSDate *invDate = [[NSDate alloc]init];
        invDate = [dateFormat dateFromString:dateString];
        NSDate *dueDate = [invDate dateByAddingTimeInterval:invTerms*24*60*60];
        if ([now compare:dueDate] == NSOrderedDescending) {
            NSLog(@"Today is later than Inv_date");
            [invoicesDue addObject:invoice];
        }
        invDate = nil;
    }
}

-(void) upcomingCalendarEvents
{

}
-(NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

#pragma TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([invoicesDue count] == 0) {
        return 1;
    }
    return [invoicesDue count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if ([invoicesDue count] == 0) {
        cell.textLabel.text = @"Your all up to Date.......";
        return cell;
    }
    Invoice *invoiceSelected = [invoicesDue objectAtIndex:indexPath.row];
    Client *client = invoiceSelected.clientForInvoice;
    
    //Client Name Label
    CGRect clientFrame = CGRectMake(10, 30, 200, 20);
    UILabel *clientLabel = [[UILabel alloc] initWithFrame:clientFrame];
    clientLabel.tag = 0011;
    clientLabel.font = [UIFont boldSystemFontOfSize:16];
    clientLabel.backgroundColor = [UIColor clearColor];
    clientLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:clientLabel];
    
    clientLabel.text = client.company;
    
    //Compnay Name Label
    CGRect companyFrame = CGRectMake(310, 30, 200, 20);
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:companyFrame];
    companyLabel.tag = 0012;
    companyLabel.font = [UIFont boldSystemFontOfSize:16];
    companyLabel.backgroundColor = [UIColor clearColor];
    companyLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:companyLabel];
    
    
    //Get Date Info
    NSDate *now = [[NSDate alloc] init];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSDate *invDate = [dateFormat dateFromString:invoiceSelected.date];
    
    NSUInteger *daysDiff = [self daysBetweenDate:invDate andDate:now];
    NSString *labelString = [NSString stringWithFormat:@"%lu Days Late", daysDiff];
    companyLabel.text = labelString;
    
    //Outstanding Name Label
    CGRect outstandingFrame = CGRectMake(660, 30, 50, 20);
    UILabel *outstandingLabel = [[UILabel alloc] initWithFrame:outstandingFrame];
    outstandingLabel.tag = 0013;
    outstandingLabel.font = [UIFont boldSystemFontOfSize:16];
    outstandingLabel.backgroundColor = [UIColor clearColor];
    outstandingLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:outstandingLabel];
    
    outstandingLabel.text = invoiceSelected.invoiceNumber;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
