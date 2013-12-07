//
//  Invoice+Get_Stored.m
//  Freelance_assistant
//
//  Created by Rich Allen on 05/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "Invoice+Get_Stored.h"

@implementation Invoice (Get_Stored)


+(NSArray *) getStoredInvoices:(id)sender inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSMutableArray *tempInvoiceArray =[[NSMutableArray alloc]init];
    
    //Get Invoices
    
    NSArray *invoices = [[NSArray alloc]initWithArray:tempInvoiceArray];
    return invoices;
}

@end
