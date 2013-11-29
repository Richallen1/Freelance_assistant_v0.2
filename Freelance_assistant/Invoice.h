//
//  Invoice.h
//  Freelance_assistant
//
//  Created by Rich Allen on 27/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Client, Invoice_charges;

@interface Invoice : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * invoiceNumber;
@property (nonatomic, retain) NSString * projectName;
@property (nonatomic, retain) NSString * subTotal;
@property (nonatomic, retain) NSString * total;
@property (nonatomic, retain) NSString * vat;
@property (nonatomic, retain) Client *clientForInvoice;
@property (nonatomic, retain) NSSet *invoice_charges;
@end

@interface Invoice (CoreDataGeneratedAccessors)

- (void)addInvoice_chargesObject:(Invoice_charges *)value;
- (void)removeInvoice_chargesObject:(Invoice_charges *)value;
- (void)addInvoice_charges:(NSSet *)values;
- (void)removeInvoice_charges:(NSSet *)values;

@end
