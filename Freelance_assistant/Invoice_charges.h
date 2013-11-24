//
//  Invoice_charges.h
//  Freelance_assistant
//
//  Created by Richard Allen on 24/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Invoice;

@interface Invoice_charges : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * vat;
@property (nonatomic, retain) NSString * total;
@property (nonatomic, retain) NSString * qty;
@property (nonatomic, retain) Invoice *invoice_head;

@end
