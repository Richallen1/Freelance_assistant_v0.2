//
//  invoiceViewController.h
//  Freelance_assistant
//
//  Created by Rich Allen on 16/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddChargeTableViewController.h"


@interface invoiceViewController : UIViewController <UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userCompanyName;
@property (weak, nonatomic) IBOutlet UILabel *userAddress1;
@property (weak, nonatomic) IBOutlet UILabel *userAddress2;

@property (weak, nonatomic) IBOutlet UITextField *clientName;
@property (weak, nonatomic) IBOutlet UITextField *projectName;
@property (weak, nonatomic) IBOutlet UITextField *invoiceNumber;
@property (nonatomic, strong) NSMutableArray *invoiceRows;
@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UILabel *subTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *vatLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;


- (IBAction)addItemButton:(id)sender;
- (void) addChargeViewController:(AddChargeTableViewController *)sender chargeDictionary:(id)dict;
- (void) updateTotals:(NSMutableDictionary *)dict;

- (IBAction)editInvoice:(id)sender;


@end
