//
//  Client.h
//  Freelance_assistant
//
//  Created by Rich Allen on 12/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Invoice;

@interface Client : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * paymentTerms;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSSet *clientInvoices;
@end

@interface Client (CoreDataGeneratedAccessors)

- (void)addClientInvoicesObject:(Invoice *)value;
- (void)removeClientInvoicesObject:(Invoice *)value;
- (void)addClientInvoices:(NSSet *)values;
- (void)removeClientInvoices:(NSSet *)values;

@end
