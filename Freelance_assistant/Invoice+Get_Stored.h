//
//  Invoice+Get_Stored.h
//  Freelance_assistant
//
//  Created by Rich Allen on 05/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "Invoice.h"

@interface Invoice (Get_Stored)

+(NSArray *) getStoredInvoices:(id)sender inManagedObjectContext:(NSManagedObjectContext *)context;

@end
