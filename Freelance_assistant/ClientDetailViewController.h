//
//  ClientDetailViewController.h
//  Freelance_assistant
//
//  Created by Rich Allen on 13/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"
@interface ClientDetailViewController : UIViewController
{
IBOutlet UITextField *firstNameText;
IBOutlet UITextField *surnameText;
IBOutlet UITextField *companyText;
IBOutlet UITextField *addressText;
IBOutlet UITextField *address2Text;
IBOutlet UITextField *cityText;
IBOutlet UITextField *stateText;
IBOutlet UITextField *zipText;
IBOutlet UITextField *countryText;
IBOutlet UITextField *phoneText;
IBOutlet UITextField *emailText;
IBOutlet UITableView *outstandingTable;
}
@property (nonatomic, strong) Client *clientSelected;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
- (IBAction)updateClient:(id)sender;
- (IBAction)deleteClient:(id)sender;







@end
