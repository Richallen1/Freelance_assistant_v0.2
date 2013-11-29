//
//  Invoice+Create.h
//  Freelance_assistant
//
//  Created by Rich Allen on 26/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "Invoice.h"
#import "Invoice.h"

@interface Invoice (Create)

+ (Invoice *)invoiceChargesWithInvoiceInfo:(NSDictionary *)invoiceInfo
          inManagedObjectContext:(NSManagedObjectContext *)context;

@end
