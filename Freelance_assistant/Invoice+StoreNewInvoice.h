//
//  Invoice+StoreNewInvoice.h
//  Freelance_assistant
//
//  Created by Rich Allen on 20/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "Invoice.h"

@interface Invoice (StoreNewInvoice)

+ (Invoice *)invoiceWithName:(NSString *)name
                inManagedObjectContext:(NSManagedObjectContext *)context;
@end
