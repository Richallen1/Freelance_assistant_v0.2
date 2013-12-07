//
//  ClientPickerViewController.h
//  Freelance_assistant
//
//  Created by Richard Allen on 29/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"

@class ClientPickerViewController;

@protocol ClientPickerViewDelegate
@optional
- (void) clientPickerViewController:(ClientPickerViewController *)sender selectedClient:(id)client;
- (void) passClientObjectDelegateMethod:(ClientPickerViewController *)sender clientSelected:(id)client;
@end

@interface ClientPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *clientPicker;
@property (weak, nonatomic) id <ClientPickerViewDelegate> delegate;
@property (strong, nonatomic) NSArray *clients;

@end
