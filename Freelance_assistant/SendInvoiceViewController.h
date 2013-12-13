//
//  SendInvoiceViewController.h
//  Freelance_assistant
//
//  Created by Rich Allen on 12/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"

@interface SendInvoiceViewController : UIViewController

@property (nonatomic, strong) NSString *PDFFilenameForSending;

-(void)initVariblesWithFileName:(NSString *)fileName andClient:(Client *)client;

@end
