//
//  SendInvoiceViewController.m
//  Freelance_assistant
//
//  Created by Rich Allen on 12/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "SendInvoiceViewController.h"


@interface SendInvoiceViewController ()

@end

@implementation SendInvoiceViewController
@synthesize PDFFilenameForSending=_PDFFilenameForSending;



- (void)viewDidLoad
{
    [super viewDidLoad];
   // NSLog(@"%@", PDFFilenameForSending);
}





-(void)initVariblesWithFileName:(NSString *)fileName andClient:(Client *)client
{
    _PDFFilenameForSending = [[NSString alloc]init];
    _PDFFilenameForSending = fileName;
    NSLog(@"%@", _PDFFilenameForSending);
}
@end
