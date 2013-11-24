//
//  invoiceViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 16/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "invoiceViewController.h"


@interface invoiceViewController ()<AddChargeTableViewDelegate>
{
    NSMutableArray *arr;
    float total;
    float subTotal;
    float vat;
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

@synthesize tblView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	_invoiceRows = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   // return 10;
    
    
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
    NSString *priceStr = [NSString stringWithFormat:@"£%@", [dict objectForKey:@"Price"]];
    priceLabel.text = priceStr;
    [cell.contentView addSubview:priceLabel];
    
    CGRect qtyFrame = CGRectMake(500, 15, 40, 20);
    UILabel *qtyLabel = [[UILabel alloc] initWithFrame:qtyFrame];
    qtyLabel.tag = 0011;
    //qtyLabel.backgroundColor =[UIColor blueColor];
    qtyLabel.font = [UIFont systemFontOfSize:16];
    qtyLabel.text = [dict objectForKey:@"Qty"];
    [cell.contentView addSubview:qtyLabel];
    
    CGRect vatFrame = CGRectMake(570, 15, 50, 20);
    UILabel *vatLabel = [[UILabel alloc] initWithFrame:vatFrame];
    vatLabel.tag = 0011;
    //vatLabel.backgroundColor =[UIColor blueColor];
    vatLabel.font = [UIFont systemFontOfSize:16];
    NSString *vatTempStr = [NSString stringWithFormat:@"£%@", [dict objectForKey:@"VAT"]];
    vatLabel.text = vatTempStr;
    [cell.contentView addSubview:vatLabel];
    
    CGRect totalFrame = CGRectMake(650, 15, 50, 20);
    UILabel *totalLabel = [[UILabel alloc] initWithFrame:totalFrame];
    totalLabel.tag = 0011;
    //totalLabel.backgroundColor =[UIColor redColor];
    totalLabel.font = [UIFont systemFontOfSize:16];
    NSString *totalTempStr = [NSString stringWithFormat:@"£%@", [dict objectForKey:@"Total"]];
    totalLabel.text = totalTempStr;
    [cell.contentView addSubview:totalLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)addItemButton:(id)sender
{

    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"charge_detail_segue"]) {
        
        if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
            UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *)segue;
            [self.popoverController dismissPopoverAnimated:YES];
            self.popoverController = popoverSegue.popoverController;
        }
            [segue.destinationViewController setDelegate:self];
    }
    
}


-(void) addChargeViewController:(AddChargeTableViewController *)sender chargeDictionary:(id)dict
{
    NSLog(@"%@", dict);
    [_invoiceRows addObject:dict];
    [self.tblView reloadData];
    [self updateTotals:dict];
    NSLog(@"%lu", (unsigned long)[_invoiceRows count]);
 }

- (void) updateTotals:(NSMutableDictionary *)dict
{
    float totalFromDict = [[dict objectForKey:@"Total"] floatValue];
    float vatFromDict = [[dict objectForKey:@"VAT"] floatValue];
    
    subTotal = subTotal+totalFromDict;
    vat = vat+vatFromDict;
    
    NSString *vatLabelString = [NSString stringWithFormat:@"%0.2f", vat];
    _vatLabel.text = vatLabelString;
    
    NSString *subTotalLabelString = [NSString stringWithFormat:@"%0.2f", subTotal];
    _subTotalLabel.text = subTotalLabelString;
    
    total = vat+subTotal;
    
    NSString *totalLabelString = [NSString stringWithFormat:@"%0.2f", total];
    _totalLabel.text = totalLabelString;
    
}

- (IBAction)editInvoice:(id)sender
{
    NSLog(@"Entered Editing Mode....");
    

}

@end
