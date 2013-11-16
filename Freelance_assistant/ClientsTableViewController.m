//
//  ClientsTableViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 12/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "ClientsTableViewController.h"
#import "Client.h"
#import "AppDelegate.h"
#import "ClientDetailViewController.h"
#import "SWRevealViewController.h"

@interface ClientsTableViewController ()
{
    NSManagedObjectContext *context;
}
@end

@implementation ClientsTableViewController
@synthesize sidebarButton=_sidebarButton;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
    //Build Table Header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
    headerView.backgroundColor = [UIColor grayColor];
    UILabel *header1View = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    header1View.text = @"kjhkjh ";
    UILabel *header2View = [[UILabel alloc] initWithFrame:CGRectMake(310, 10, 200, 20)];
    header2View.text = @"kjhkjh ";
    UILabel *header3View = [[UILabel alloc] initWithFrame:CGRectMake(660, 10, 50, 20)];
    header3View.text = @"kjhkjh ";

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Client *client = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Client Name Label
    CGRect clientFrame = CGRectMake(10, 30, 200, 20);
    UILabel *clientLabel = [[UILabel alloc] initWithFrame:clientFrame];
    clientLabel.tag = 0011;
    clientLabel.font = [UIFont boldSystemFontOfSize:16];
    clientLabel.backgroundColor = [UIColor clearColor];
    clientLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:clientLabel];
    
    clientLabel.text = client.firstName;
    
    //Compnay Name Label
    CGRect companyFrame = CGRectMake(310, 30, 200, 20);
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:companyFrame];
    companyLabel.tag = 0012;
    companyLabel.font = [UIFont boldSystemFontOfSize:16];
    companyLabel.backgroundColor = [UIColor clearColor];
    companyLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:companyLabel];
    
    companyLabel.text = client.company;
    
    //Outstanding Name Label
    CGRect outstandingFrame = CGRectMake(660, 30, 50, 20);
    UILabel *outstandingLabel = [[UILabel alloc] initWithFrame:outstandingFrame];
    outstandingLabel.tag = 0013;
    outstandingLabel.font = [UIFont boldSystemFontOfSize:16];
    outstandingLabel.backgroundColor = [UIColor clearColor];
    outstandingLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:outstandingLabel];
    
    outstandingLabel.text = @"$0.00";
    
    return cell;
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    
    NSLog(@"sdfsdfsdf");
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Client"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"company"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"client_detail_segue"]) {
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Client *client = [self.fetchedResultsController objectAtIndexPath:path];
        [segue.destinationViewController setClientSelected:client];
       
    }
}



@end
