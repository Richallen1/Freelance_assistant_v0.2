//
//  invoiceViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 16/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "invoiceViewController.h"
#import "AppDelegate.h"
#import "Client.h"
#import "Invoice_charges.h"
#import "PDFViewController.h"
#import "PDFPublisherController.h"

@interface invoiceViewController ()<AddChargeTableViewDelegate, ClientPickerViewDelegate>
{
    NSMutableArray *arr;
    NSManagedObjectContext *context;
    Client *clientSelected;
}
@property (nonatomic, strong) UIPopoverController *popoverController;
@end

@implementation invoiceViewController
@synthesize userCompanyName=_userCompanyName;
@synthesize userAddress1=_userAddress1;
@synthesize userAddress2=_userAddress2;
@synthesize clientName=_clientName;
@synthesize projectName=_projectName;
@synthesize invoiceNumber=_invoiceNumber;
@synthesize invoiceRows=_invoiceRows;
@synthesize popoverController;
@synthesize subTotalLabel=_subTotalLabel;
@synthesize vatLabel=_vatLabel;
@synthesize editButton=_editButton;
@synthesize doneButton=_doneButton;
@synthesize tblView;
@synthesize invoiceSelected=_invoiceSelected;
@synthesize dateField=_dateField;
@synthesize completeInvoiceButton=_completeInvoiceButton;

#pragma View Lifecycle and Init Methods
/**********************************************************
 Method:(void)viewDidLoad
 Description:View Load Method
 Tag:View LifeCycle
 **********************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Get Date Info
    NSDate *now = [[NSDate alloc] init];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd/MM/yyyy"];
	NSString *todaysDate = [dateFormat stringFromDate:now];
	_dateField.text=todaysDate;
    
    if (_invoiceSelected != nil) {
        NSLog(@"%@", _invoiceSelected.total);
        //Passed Parameter not empty
        [self fillDataWithInvoiceSelected];
    }
    else
    {
        _invoiceRows = [[NSMutableArray alloc]init];
    }
    //Hide Done Button
    _doneButton.width = 0.01;
    
    //LOAD USER DATA FROM NSUSER DEFAULTS
    [self getUserInformation];
    
    //Core Data Context Declaration from App delegate shared context
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
    self.clientName.delegate = self;
}
/**********************************************************
 Method:(void)getUserInformation
 Description:Function get user information from NSUserDefaults
 Tag:Data Collection
 **********************************************************/
- (void)getUserInformation
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"User_Name"] != nil) {
        _userCompanyName.text = [defaults objectForKey:@"User_Name"];
    }
    if ([defaults objectForKey:@"User_Address_1"] != nil) {
        _userAddress1.text = [defaults objectForKey:@"User_Address_1"];
    }
    if ([defaults objectForKey:@"User_Address_2"] != nil) {
       _userAddress2.text = [defaults objectForKey:@"User_Address_2"];
    }
}

/**********************************************************
 Method:(void)removeRowAndUpdateForRow:(NSIndexPath *)indexPath
 Description:Removes a row from the charges table
 Tag:Table View
 **********************************************************/
-(void)removeRowAndUpdateForRow:(NSIndexPath *)indexPath
{
    //Method Instance Vars
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict = [_invoiceRows objectAtIndex:indexPath.row];
    [_invoiceRows removeObjectAtIndex: indexPath.row];
    [tblView reloadData];
    [self updateLabels];
}
#pragma SEGUE METHODS
/**********************************************************
 Method:(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
 Description:Segue delegate methods (Overidden)
 Tag:Segue
 **********************************************************/
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"Preview Segue"]) {
        if (clientSelected ==nil) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Opps!! I think you missed something!" message:@"You missed out the client to invoice. You need to enter one before going on." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return false;
        }
        if ([_projectName.text  isEqual: @""]) {
            UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"Opps!! I think you missed something!" message:@"You missed out the project name. You need to enter one before going on." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert2 show];
            return false;
        }
        if ([_invoiceNumber.text  isEqual: @""]) {
            UIAlertView *alert3 = [[UIAlertView alloc]initWithTitle:@"Opps!! I think you missed something!" message:@"You missed out the project name. You need to enter one before going on." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert3 show];
            return false;
        }
        return true;
    }
    //Any other Segue
    return true;
}
/**********************************************************
 Method:(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 Description:Segue delegate methods (Overidden)
 Tag:Segue
 **********************************************************/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"charge_detail_segue"]) {
        if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
            UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *)segue;
            [self.popoverController dismissPopoverAnimated:YES];
            self.popoverController = popoverSegue.popoverController;
        }
            [segue.destinationViewController setDelegate:self];
    }
    if ([segue.identifier isEqualToString:@"Preview Segue"]) {
        NSLog(@"Preview Segue");
        [self saveInvoice];
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
        [mutableDict setObject:clientSelected.company forKey:@"name"];
        
        //Proj Details
        [mutableDict setValue:_projectName.text forKey:@"projectName"];
        [mutableDict setValue:_invoiceNumber.text forKey:@"invoiceNumber"];
        [mutableDict setValue:_dateField.text forKey:@"invoiceDate"];

        NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:mutableDict];
        
            NSString *fileCreated = [PDFPublisherController PublishPDFWithData:_invoiceRows withClientDetails:dict forClient:clientSelected];
            PDFViewController *pvc = segue.destinationViewController;
            pvc.fileName = _invoiceNumber.text;
            pvc.filePath = fileCreated;
            pvc.client = clientSelected;
            pvc.projectName = _projectName.text;
    }
    if ([segue.identifier isEqualToString:@"client_segue"]) {
        if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
            UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *)segue;
            [self.popoverController dismissPopoverAnimated:YES];
            self.popoverController = popoverSegue.popoverController;
        }
        [segue.destinationViewController setDelegate:self];
    }
}
/**********************************************************
 Method:(void) addChargeViewController:(AddChargeTableViewController *)sender chargeDictionary:(id)dict
 Description:Custom delegate method from the popover to add a charge tio the table.
 Tag:Custom Delegate
 **********************************************************/
-(void) addChargeViewController:(AddChargeTableViewController *)sender chargeDictionary:(id)dict
{
    NSLog(@"%@", dict);
    [_invoiceRows addObject:dict];
    [self.tblView reloadData];
    
    float fl = [[dict objectForKey:@"subTotal"]floatValue];
    NSLog(@"total - %f", fl);
    NSLog(@"%lu", (unsigned long)[_invoiceRows count]);
    
    NSLog(@"Dictionary Added: %@",dict);
    
    [self updateLabels];
 }
/**********************************************************
 Method:(void)updateLabels
 Description:Updates the total, vat and subtotal labels based on the array of charges.
 Tag:Math / UIStuff
 **********************************************************/
-(void)updateLabels
{
    float subTotal;
    float vat = 0.00;
    
    for (NSMutableDictionary *dict in _invoiceRows)
    {
        NSLog(@"Dictionary - %@", dict);
        
        float subTotalTemp = [[dict objectForKey:@"Price"] floatValue];
        float vatTemp = [[dict objectForKey:@"VAT"] floatValue];
        
        NSLog(@"VAT Temp - %f", vatTemp);
        NSLog(@"VAT - %f", vat);
        
        subTotal = subTotal+subTotalTemp;
        vat = vat+vatTemp;
    }
    float total_UpdateLabel;
    
    NSString *vatLabelString = [NSString stringWithFormat:@"%0.2f", vat];
    _vatLabel.text = vatLabelString;
    
    NSString *subTotalLabelString = [NSString stringWithFormat:@"%0.2f", subTotal];
    _subTotalLabel.text = subTotalLabelString;
    
    total_UpdateLabel = subTotal+vat;
    
    NSString *totalLabelString = [NSString stringWithFormat:@"%0.2f", total_UpdateLabel];
    _totalLabel.text = totalLabelString;
}
/**********************************************************
 Method:(IBAction)editInvoice:(id)sender
 Description:Puts the Charge table view into editing mode
 Tag:TableView
 **********************************************************/
- (IBAction)editInvoice:(id)sender
{
    NSLog(@"Entered Editing Mode....");
    
    if (tblView.editing == NO)
    {
        _editButton.tintColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [tblView setEditing: YES animated: YES];
    }
    else
    {
        NSLog(@"End Editing Mode....");
        _editButton.tintColor = nil;
        
        [tblView setEditing: NO animated: YES];
    }
}
#pragma mark - Core Data Methods
/**********************************************************
 Method:(void)saveInvoice
 Description:Saves a new Invoice
 Tag:Core Data
 **********************************************************/
- (void)saveInvoice
{
    Invoice *newInvoice = nil;
    
    newInvoice = [NSEntityDescription insertNewObjectForEntityForName:@"Invoice" inManagedObjectContext:context];
    
    //newInvoice.invoiceNumber = @"123";
    newInvoice.date = _dateField.text;
    newInvoice.invoiceNumber = _invoiceNumber.text;
    newInvoice.projectName = _projectName.text;
    newInvoice.subTotal = _subTotalLabel.text;
    newInvoice.total = _totalLabel.text;
    newInvoice.vat = _vatLabel.text;
    newInvoice.clientForInvoice = clientSelected;
    NSMutableSet *tempSet = [[NSMutableSet alloc]init];

    for (NSMutableDictionary *dict in _invoiceRows)
    {
        [tempSet addObject:[self InvoiceWithDict:dict invoiceForCharges:newInvoice]];
    }
    newInvoice.invoice_charges = tempSet;
    
    NSError *err;
    [context save:&err];
    
}
/**********************************************************
 Method:(void) InvoiceWithDict:(NSMutableDictionary *)dict invoiceForCharges:(Invoice *)inv
 Description:Updates an invoice object with the dictionary of invoice information.
 Tag:Core Data
 **********************************************************/
-(Invoice_charges *) InvoiceWithDict:(NSMutableDictionary *)dict invoiceForCharges:(Invoice *)inv
{
    Invoice_charges *newCharge = nil;
    
    newCharge = [NSEntityDescription insertNewObjectForEntityForName:@"Invoice_charges" inManagedObjectContext:context];
  
    NSString *priceStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Price"]];
    NSString *totalStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Total"]];
    NSString *vatStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"VAT"]];
    NSString *qtyStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Qty"]];

    newCharge.date = [dict objectForKey:@"Date"];
    newCharge.price = priceStr;
    newCharge.desc = [dict objectForKey:@"Desc"];
    newCharge.vat = vatStr;
    newCharge.total = totalStr;
    newCharge.qty = qtyStr;
    
    return newCharge;
}
/**********************************************************
 Method:(void)deleteInvoiceWithNumber:(NSString *)invNumber
 Description:Deletes a invoice for a given invoice number
 Tag:Core Data
 **********************************************************/
-(void)deleteInvoiceWithNumber:(NSString *)invNumber
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Invoice"];
    request.predicate = [NSPredicate predicateWithFormat:@"invoiceNumber = %@", invNumber];
    NSError *error = nil;
    NSArray *invoices = [context executeFetchRequest:request error:&error];
    if (invoices.count == 0) {
        //Nothing to Delete.
    }
    if (invoices.count == 1) {
        //Delete all invoices matching that unique number!
        for (NSManagedObject *invoice in invoices) {
            [context deleteObject:invoice];
        }
    }
}
/**********************************************************
 Method:(void)fillDataWithInvoiceSelected
 Description:Takes a selected Invoice Obj from the prev VC and fills the text fields
 Tag:Core Data
 **********************************************************/
-(void)fillDataWithInvoiceSelected
{
    _dateField.text = _invoiceSelected.date;
    _projectName.text = _invoiceSelected.projectName;
    _invoiceNumber.text = _invoiceSelected.invoiceNumber;
    Client *cl = _invoiceSelected.clientForInvoice;
    _clientName.text = cl.company;
     _invoiceRows = [[NSMutableArray alloc]init];
    
    NSSet *chargesSet = _invoiceSelected.invoice_charges;
    for (Invoice_charges *invChg in chargesSet)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];

        float priceFloat = [invChg.price floatValue];
        NSNumber *NSPrice = [[NSNumber alloc]initWithFloat:priceFloat];
        
        float totalFloat = [invChg.total floatValue];
        NSNumber *NSTotal = [[NSNumber alloc]initWithFloat:totalFloat];
        
        float vatFloat = [invChg.vat floatValue];
        NSNumber *NSVat = [[NSNumber alloc]initWithFloat:vatFloat];
        
        [dict setObject:invChg.date forKey:@"Date"];
        [dict setObject:invChg.desc forKey:@"Desc"];
        [dict setObject:NSPrice forKey:@"Price"];
        [dict setObject:NSVat forKey:@"VAT"];
        [dict setObject:NSTotal forKey:@"Total"];
        [dict setObject:invChg.qty forKey:@"Qty"];
        [_invoiceRows addObject:dict];
        
        //set dict to nil
        dict = nil;
    }
    [self updateLabels];
    [tblView reloadData];
}
/**********************************************************
 Method:(IBAction)cancelInvoice:(id)sender
 Description:Cancels users invoice ands setts outlets to nil
 Tag:textField
 **********************************************************/
- (IBAction)cancelInvoice:(id)sender
{
    //[self deleteInvoiceWithNumber:_invoiceNumber.text];
    _userCompanyName = nil;
    _userAddress1 = nil;
    _userAddress2 = nil;
    _clientName = nil;
    _projectName = nil;
    _invoiceNumber = nil;
    _invoiceRows = nil;
    popoverController = nil;
    _subTotalLabel = nil;
    _vatLabel = nil;
    _editButton = nil;
    _doneButton = nil;
    tblView = nil;
    _invoiceSelected = nil;
    _dateField = nil;
    _completeInvoiceButton = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma Client Slection Box Methods
/**********************************************************
 Method:(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
 Description:Removes the keyboard from the text field used for the client picker.
 Tag:TextField Delegate
 **********************************************************/
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _clientName) {
        [self performSegueWithIdentifier: @"client_segue" sender: self];
        return NO;
    }
    else
    {
        return YES;
    }
}
/**********************************************************
 Method:(void) clientPickerViewController:(ClientPickerViewController *)sender selectedClient:(id)client
 Description:Custom Delegate method to allow a user to select the client from a picker view
 Tag:Picker Delegate / Custom
 **********************************************************/
- (void) clientPickerViewController:(ClientPickerViewController *)sender selectedClient:(id)client
{
    NSLog(@"INV Client - %@", client);
    _clientName.text = client;
    clientSelected = [self getClientForName:client];
}
/**********************************************************
 Method: (Client *) getClientForName:(NSString *)clientName
 Description:Gets the client company name for a given (Client *)
 Tag:Utility
 **********************************************************/
- (Client *) getClientForName:(NSString *)clientName
{
    //Get Client Data from CoreData
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Client" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.predicate = [NSPredicate predicateWithFormat:@"company = %@", clientName];
    [request setEntity:desc];
    
    NSError *error;
    NSArray *data = [context executeFetchRequest:request error:&error];
    if (data.count !=0) {
        for (Client *c in data) {
            NSLog(@"%@", c.company);
            return c;
        }
    }
    Client *cl = [[Client alloc]init];
    return cl;
}

#pragma TableView Delegate Methods
/**********************************************************
 Methods: Table View Delegate Methods
 Description:
 Tag:table View
 **********************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_invoiceRows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Invoice_Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //Build Table Header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 722, 40)];
    //headerView.backgroundColor = [UIColor grayColor];
    UILabel *header1View = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)];
    header1View.text = @"Date";
    UILabel *header2View = [[UILabel alloc] initWithFrame:CGRectMake(140, 15, 240, 20)];
    header2View.text = @"Description";
    UILabel *header3View = [[UILabel alloc] initWithFrame:CGRectMake(400, 15, 80, 20)];
    header3View.text = @"Price";
    UILabel *header4View = [[UILabel alloc] initWithFrame:CGRectMake(500, 15, 40, 20)];
    header4View.text = @"Qty";
    UILabel *header5View = [[UILabel alloc] initWithFrame:CGRectMake(570, 15, 50, 20)];
    header5View.text = @"Vat";
    UILabel *header6View = [[UILabel alloc] initWithFrame:CGRectMake(650, 15, 50, 20)];
    header6View.text = @"Total";
    
    
    [headerView addSubview:header1View];
    [headerView addSubview:header2View];
    [headerView addSubview:header3View];
    [headerView addSubview:header4View];
    [headerView addSubview:header5View];
    [headerView addSubview:header6View];
    self.tblView.tableHeaderView = headerView;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict = [_invoiceRows objectAtIndex:indexPath.row];
    
    CGRect dateFrame = CGRectMake(10, 15, 100, 20);
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:dateFrame];
    dateLabel.tag = 0011;
    //dateLabel.backgroundColor =[UIColor blueColor];
    dateLabel.font = [UIFont systemFontOfSize:16];
    dateLabel.text = [dict objectForKey:@"Date"];
    [cell.contentView addSubview:dateLabel];
    
    CGRect descFrame = CGRectMake(140, 15, 240, 20);
    UILabel *descLabel = [[UILabel alloc] initWithFrame:descFrame];
    descLabel.tag = 0011;
    //descLabel.backgroundColor =[UIColor purpleColor];
    descLabel.font = [UIFont systemFontOfSize:16];
    descLabel.text = [dict objectForKey:@"Desc"];
    [cell.contentView addSubview:descLabel];
    
    CGRect priceFrame = CGRectMake(400, 15, 80, 20);
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:priceFrame];
    priceLabel.tag = 0011;
    //priceLabel.backgroundColor =[UIColor blueColor];
    priceLabel.font = [UIFont systemFontOfSize:16];
    NSString *priceStr = [NSString stringWithFormat:@"£%0.2f", [[dict objectForKey:@"Price"]floatValue]];
    priceLabel.text = priceStr;
    [cell.contentView addSubview:priceLabel];
    
    CGRect qtyFrame = CGRectMake(500, 15, 40, 20);
    UILabel *qtyLabel = [[UILabel alloc] initWithFrame:qtyFrame];
    qtyLabel.tag = 0011;
    //qtyLabel.backgroundColor =[UIColor blueColor];
    qtyLabel.font = [UIFont systemFontOfSize:16];
    qtyLabel.text = [dict objectForKey:@"Qty"];
    [cell.contentView addSubview:qtyLabel];
    
    CGRect vatFrame = CGRectMake(560, 15, 50, 20);
    UILabel *vatLabel = [[UILabel alloc] initWithFrame:vatFrame];
    vatLabel.tag = 0011;
    //vatLabel.backgroundColor =[UIColor blueColor];
    vatLabel.font = [UIFont systemFontOfSize:16];
    NSString *vatTempStr = [NSString stringWithFormat:@"%@", [dict objectForKey:@"VAT"]];
    vatLabel.text = vatTempStr;
    [cell.contentView addSubview:vatLabel];
    NSLog(@"VAT: %@", [dict objectForKey:@"VAT"]);
    
    CGRect totalFrame = CGRectMake(630, 15, 80, 20);
    UILabel *totalLabel = [[UILabel alloc] initWithFrame:totalFrame];
    totalLabel.tag = 0011;
    //totalLabel.backgroundColor =[UIColor redColor];
    totalLabel.font = [UIFont systemFontOfSize:16];
    NSString *totalTempStr = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Total"]];
    totalLabel.text = totalTempStr;
    [cell.contentView addSubview:totalLabel];
    NSLog(@"Total: %@", [dict objectForKey:@"Total"]);
    
    return cell;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
#pragma Table View Edit Methods
/**********************************************************
 Methods:Table View Edit DelegateMethods
 Description:Allows a user to edit the rows of chages on the Invoice
 Tag:Table View
 **********************************************************/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removeRowAndUpdateForRow:indexPath];
    }
}

@end