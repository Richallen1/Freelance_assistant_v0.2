//
//  InvoicesOverviewViewController.m
//  Freelance_assistant
//
//  Created by Richard Allen on 24/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "InvoicesOverviewViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "ClientDetailViewController.h"
#import "Invoice.h"
#import "invoiceViewController.h"

@interface InvoicesOverviewViewController ()
{
    NSManagedObjectContext *context;
}
@end

@implementation InvoicesOverviewViewController
@synthesize sidebarButton=_sidebarButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    //Core Data Context Declaration from App delegate shared context
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
    
    //Build Table Header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
    headerView.backgroundColor = [UIColor grayColor];
    UILabel *header1View = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    header1View.text = @"Client";
    UILabel *header2View = [[UILabel alloc] initWithFrame:CGRectMake(350, 10, 200, 20)];
    header2View.text = @"Date Due";
    UILabel *header3View = [[UILabel alloc] initWithFrame:CGRectMake(630, 10, 100, 20)];
    header3View.text = @"Amount";
    
    [headerView addSubview:header1View];
    [headerView addSubview:header2View];
    [headerView addSubview:header3View];
    self.tableView.tableHeaderView = headerView;
    
    [self setupFetchedResultsController];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma TableView Delegate Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Invoice *inv = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Client Name Label
    CGRect clientFrame = CGRectMake(10, 10, 200, 40);
    UILabel *clientLabel = [[UILabel alloc] initWithFrame:clientFrame];
    clientLabel.tag = 0011;
    clientLabel.font = [UIFont boldSystemFontOfSize:16];
    clientLabel.backgroundColor = [UIColor clearColor];
    clientLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:clientLabel];
    
    clientLabel.text = @"Client";
    
    //Compnay Name Label
    CGRect companyFrame = CGRectMake(350, 10, 200, 20);
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:companyFrame];
    companyLabel.tag = 0012;
    companyLabel.font = [UIFont boldSystemFontOfSize:16];
    companyLabel.backgroundColor = [UIColor clearColor];
    companyLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:companyLabel];
    
    companyLabel.text = inv.date;
    
    //Outstanding Name Label
    CGRect outstandingFrame = CGRectMake(630, 10, 100, 20);
    UILabel *outstandingLabel = [[UILabel alloc] initWithFrame:outstandingFrame];
    outstandingLabel.tag = 0013;
    outstandingLabel.font = [UIFont boldSystemFontOfSize:16];
    outstandingLabel.backgroundColor = [UIColor clearColor];
    outstandingLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:outstandingLabel];
    
    outstandingLabel.text = inv.total;
    
    return cell;
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    
    NSLog(@"sdfsdfsdf");
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Invoice"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Did_Select_Segue"]) {
        NSLog(@"Load Invoice from Index Path");
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Invoice *inv = [self.fetchedResultsController objectAtIndexPath:path];
        [segue.destinationViewController setInvoiceSelected:inv];
   
    }
    

    
    
}

@end