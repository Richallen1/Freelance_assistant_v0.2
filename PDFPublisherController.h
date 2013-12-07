//
//  PDFPublisherController.h
//  pdfGenerator
//
//  Created by Richard Allen on 07/12/2013.
//  Copyright (c) 2013 Richard Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Invoice.h"
#import "Invoice_charges.h"

@interface PDFPublisherController : NSObject

- (BOOL)publishPdfWithInvoice:(Invoice *)data;

@end
