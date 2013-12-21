//
//  invoiceViewController.h
//  Freelance_assistant
//
//  Created by Rich Allen on 16/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddChargeTableViewController.h"
#import "Invoice.h"
#import "Invoice_charges.h"
#import "ClientPickerViewController.h"

@interface invoiceViewController : UIViewController <UIPopoverControllerDelegate, UITextFieldDelegate>
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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) Invoice *invoiceSelected;
@property (strong, nonatomic) NSMutableDictionary *projectInfo;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *completeInvoiceButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendInvoiceButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

- (void) clientPickerViewController:(ClientPickerViewController *)sender selectedClient:(id)client;
- (void) addChargeViewController:(AddChargeTableViewController *)sender chargeDictionary:(id)dict;
- (void)removeRowAndUpdateForRow:(NSIndexPath *)indexPath;
- (IBAction)editInvoice:(id)sender;
- (void)updateLabels;
- (void)getUserInformation;
- (void)fillDataWithInvoiceSelected;
- (void)deleteInvoiceWithNumber:(NSString *)invNumber;
- (void)saveInvoice;

-(Invoice_charges *) InvoiceWithDict:(NSMutableDictionary *)dict invoiceForCharges:(Invoice *)inv;
@end
