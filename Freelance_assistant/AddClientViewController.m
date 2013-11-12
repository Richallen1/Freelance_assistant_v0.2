//
//  AddClientViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 11/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "AddClientViewController.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"

@interface AddClientViewController ()
{
    NSManagedObjectContext *context;
  
}
@end

@implementation AddClientViewController
@synthesize firstNameTextField = _firstNameTextField;
@synthesize lastNameTextField = _lastNameTextField;

@synthesize  companyField=_companyField;
@synthesize  addressField=_addressField;
@synthesize  addressField2=_addressField2;
@synthesize  cityField=_cityField;
@synthesize  stateField=_stateField;
@synthesize  zipField=_zipField;
@synthesize  phoneField=_phoneField;
@synthesize  countryField=_countryField;
@synthesize  emailField=_emailField;
@synthesize paymentTerms=_paymentTerms;
@synthesize clientsArray=_clientsArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];


    [[self firstNameTextField]setDelegate:self];
    [[self lastNameTextField]setDelegate:self];
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (IBAction)addClient:(id)sender
{
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Client" inManagedObjectContext:context];
    NSManagedObject *newClient = [[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:context];
    
    NSString *paymentTerm = [[NSString alloc]init];
    
    if (_paymentTerms.selectedSegmentIndex == 0) {
        NSLog(@"1");
        paymentTerm = @"14";
    }
    if (_paymentTerms.selectedSegmentIndex == 1) {
        NSLog(@"2");
        paymentTerm = @"30";
    }
    if (_paymentTerms.selectedSegmentIndex == 2) {
        NSLog(@"3");
        paymentTerm = @"60";
    }
    if (_paymentTerms.selectedSegmentIndex == 3) {
        NSLog(@"4");
        paymentTerm = @"Other";
    }
    
    [newClient setValue:self.firstNameTextField.text forKey:@"firstName"];
    [newClient setValue:self.lastNameTextField.text forKey:@"lastName"];
    [newClient setValue:self.companyField.text forKey:@"company"];
    [newClient setValue:self.addressField.text forKey:@"address"];
    [newClient setValue:self.addressField2.text forKey:@"address2"];
    [newClient setValue:self.cityField.text forKey:@"city"];
    [newClient setValue:self.stateField.text forKey:@"state"];
    [newClient setValue:self.zipField.text forKey:@"zip"];
    [newClient setValue:self.phoneField.text forKey:@"phone"];
    [newClient setValue:self.emailField.text forKey:@"email"];
    [newClient setValue:paymentTerm forKey:@"paymentTerms"];

    NSError *err;
    [context save:&err];
}

#pragma TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
