//
//  AddChargeTableViewController.h
//  Freelance_assistant
//
//  Created by Rich Allen on 19/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddChargeTableViewController;

@protocol AddChargeTableViewDelegate
@optional
- (void) addChargeViewController:(AddChargeTableViewController *)sender chargeDictionary:(id)dict;
- (void) dismissPopover:(AddChargeTableViewController *)sender;
@end

@interface AddChargeTableViewController : UITableViewController <UIAlertViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *chargeDescField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextField *qtyField;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISwitch *vatSwitch;
@property (weak, nonatomic) id <AddChargeTableViewDelegate> delegate;

- (IBAction)vatSwitchChange:(id)sender;
- (IBAction)doneButton:(id)sender;
- (IBAction)priceChanged:(id)sender;
- (IBAction)qtyChanged:(id)sender;


@end
