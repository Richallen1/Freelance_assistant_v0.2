//
//  AddChargeTableViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 19/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "AddChargeTableViewController.h"
#import "invoiceViewController.h"


@interface AddChargeTableViewController ()
{
    float vatAmount;
    float totalAmount;
    
    //did Edit cost fields
    int qty;
    float total;
    float vatRate;
}
@end

@implementation AddChargeTableViewController
@synthesize chargeDescField=_chargeDescField;
@synthesize priceField=_priceField;
@synthesize qtyField=_qtyField;
@synthesize totalLabel=_totalLabel;
@synthesize vatSwitch=_vatSwitch;
@synthesize delegate=_delegate;
@synthesize dateField=_dateField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Charge Details";
    _vatSwitch.on = false;
    vatAmount = 0;
    total = 0;
    vatRate = 0.2;
    
    //Get Date Info
    NSDate *now = [[NSDate alloc] init];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd/MM/yyyy"];
	NSString *todaysDate = [dateFormat stringFromDate:now];
	_dateField.text=todaysDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    return cell;
}
- (IBAction)vatSwitchChange:(id)sender
{
    if (_vatSwitch.on == true)
    {
        NSLog(@"Vat Amount %.02f", total);
        vatAmount = vatRate*total;
        NSLog(@"Vat Amount %.02f", vatAmount);
        total = total+vatAmount;
        NSLog(@"£%.02f", total);
        NSString *str  =[NSString stringWithFormat:@"£%.02f", total];
        _totalLabel.text = str;
    }
    else
    {
        total = total/120*100;
        NSString *str  =[NSString stringWithFormat:@"£%.02f", total];
        _totalLabel.text = str;
    }
}
- (IBAction)doneButton:(id)sender
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];

    float subTotal = total - vatAmount;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *subTotalAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:subTotal]];
    NSString *vatAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:vatAmount]];
    NSString *totalAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    
    
    
    if ([_dateField.text  isEqual: @""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"No Date" message:@"Please enter the date of the charge" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    if ([_chargeDescField.text  isEqual: @""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"No Description" message:@"Please enter a description of the charge" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    if ([_priceField.text isEqual:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"No Price" message:@"Please enter the price of the charge" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    if ([_qtyField.text isEqual:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"No Quantity" message:@"Please enter a quantity of the charge" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    else
    {
        [dict setObject:_dateField.text forKey:@"Date"];
        [dict setObject:_chargeDescField.text forKey:@"Desc"];
        [dict setObject:_priceField.text forKey:@"Price"];
        [dict setObject:_qtyField.text forKey:@"Qty"];
        [dict setObject:totalAsString forKey:@"Total"];
        [dict setObject:vatAsString forKey:@"VAT"];
        [dict setObject:subTotalAsString forKey:@"subTotal"];
        [self.delegate addChargeViewController:self chargeDictionary:dict];
    }
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (IBAction)priceChanged:(id)sender
{
    NSLog(@"Price Changed");
    total = [_priceField.text integerValue];
    NSLog(@"%f", total);
    NSString *str  =[NSString stringWithFormat:@"£%.02f", total];
    _totalLabel.text = str;
    _qtyField.text = @"";
}

- (IBAction)qtyChanged:(id)sender
{
    NSLog(@"Qty Changed");
    qty = [_qtyField.text integerValue];
    total = total * qty;
    NSString *str  =[NSString stringWithFormat:@"£%.02f", total];
    _totalLabel.text = str;
}

@end
