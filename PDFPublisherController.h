//
//  PDFPublisherController.h
//  pdfGenerator
//
//  Created by Richard Allen on 07/12/2013.
//  Copyright (c) 2013 Richard Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Client.h"

static NSArray *invoiceRowData;
static  NSDictionary *invoiceClientData;

@interface PDFPublisherController : NSObject

+(NSString *)PublishPDFWithData:(NSArray *)invoiceRows withClientDetails:(NSDictionary *)invDetails forClient:(Client *)clientSelected;

+(void)drawPDF:(NSString*)fileName;

+(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to;

+(void)drawImage:(UIImage*)image inRect:(CGRect)rect;

+(void)drawText:(NSString*)textToDraw inFrame:(CGRect)frameRect;

+(void)drawLabelsWithInvoiceDetails:(NSDictionary *)dict andSelectedClient:(Client *)clientSelected;

+(void)drawLogo;

+(CGPoint)createRowAt:(CGPoint)origin
                data1:(NSString *)col1
                data2:(NSString *)col2
                data3:(NSString *)col3
                data4:(NSString *)col4
                data5:(NSString *)col5;

+(NSString*)getPDFFileName;
+(NSString*)getPDFFileNameWithProjInfo:(NSString *)file;


@end
