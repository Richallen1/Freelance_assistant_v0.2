//
//  Invoice.h
//  Freelance_assistant
//
//  Created by Rich Allen on 12/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Client;

@interface Invoice : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * invoiceNumber;
@property (nonatomic, retain) NSString * projectName;
@property (nonatomic, retain) NSString * subTotal;
@property (nonatomic, retain) NSString * total;
@property (nonatomic, retain) NSString * vat;
@property (nonatomic, retain) Client *clientForInvoice;

@end
