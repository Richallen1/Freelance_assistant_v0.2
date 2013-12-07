//
//  ClientPickerViewController.m
//  Freelance_assistant
//
//  Created by Richard Allen on 29/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "ClientPickerViewController.h"
#import "AppDelegate.h"
#import "Client.h"

@interface ClientPickerViewController ()
{
    NSManagedObjectContext *context;
}
@end

@implementation ClientPickerViewController
@synthesize delegate=_delegate;
@synthesize clients=_clients;
@synthesize clientPicker=_clientPicker;


- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
    [self getClients];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getClients
{
    //Get Client Data from CoreData
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Client" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:desc];
    
    NSError *error;
    NSArray *data = [context executeFetchRequest:request error:&error];
    
    NSMutableArray *clientsLocal = [[NSMutableArray alloc]init];
    
    for (Client *client in data) {
        [clientsLocal addObject:client.company];
    }
    self.clients = [[NSArray alloc]initWithArray:clientsLocal];
    return;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.clients count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

   return [self.clients objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{    
    NSLog(@"Selected Row %d", row);
    NSString *clientFromPicker = [[NSString alloc]init];
    clientFromPicker = [self.clients objectAtIndex:row];
    [self.delegate clientPickerViewController:self selectedClient:clientFromPicker];
    
  //  [self getClientForName:[self.clients objectAtIndex:row]];
    
}

@end
