//
//  ClientDetailViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 13/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "ClientDetailViewController.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"

@interface ClientDetailViewController ()
{
    NSManagedObjectContext *context;
}
@end

@implementation ClientDetailViewController
@synthesize clientSelected=_clientSelected;
@synthesize sidebarButton=_sidebarButton;
- (void)viewDidLoad
{
    [super viewDidLoad];
	AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self fillTextFeilds:_clientSelected];
}

-(void) setClientSelected:(Client *)clientSelected
{
    _clientSelected = clientSelected;
    NSLog(@"%@",clientSelected.firstName);


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateClient:(id)sender
{
    [_clientSelected setValue:firstNameText.text forKey:@"firstName"];
    [_clientSelected setValue:surnameText.text forKey:@"lastName"];
    [_clientSelected setValue:companyText.text forKey:@"company"];
    [_clientSelected setValue:addressText.text forKey:@"address"];
    [_clientSelected setValue:address2Text.text forKey:@"address2"];
    [_clientSelected setValue:cityText.text forKey:@"city"];
    [_clientSelected setValue:stateText.text forKey:@"state"];
    [_clientSelected setValue:zipText.text forKey:@"zip"];
    [_clientSelected setValue:phoneText.text forKey:@"phone"];
    [_clientSelected setValue:emailText.text forKey:@"email"];
 
    NSError *err;
    [context save:&err];
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)deleteClient:(id)sender
{
    [context deleteObject:_clientSelected];
    NSError *err;
    [context save:&err];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)fillTextFeilds: (Client *)client
{
    firstNameText.text = client.firstName;
    surnameText.text = client.lastName;
    companyText.text = client.company;
    addressText.text = client.address;
    address2Text.text = client.address2;
    cityText.text = client.city;
    stateText.text = client.state;
    zipText.text = client.zip;
    countryText.text = client.firstName;
    phoneText.text = client.phone;
    emailText.text = client.email;
}
@end
