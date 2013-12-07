//
//  invoiceViewController+PDFPublisher.h
//  Freelance_assistant
//
//  Created by Richard Allen on 07/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "invoiceViewController.h"
#import "Invoice.h"
#import "Invoice_charges.h"

@interface invoiceViewController (PDFPublisher)

+ (BOOL)publishPdfWithInvoice:(Invoice *)data;

@end
