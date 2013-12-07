//
//  invoiceViewController+PDFPublisher.m
//  Freelance_assistant
//
//  Created by Richard Allen on 07/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import "invoiceViewController+PDFPublisher.h"

@implementation invoiceViewController (PDFPublisher)

+ (BOOL)publishPdfWithInvoice:(Invoice *)data
{
    BOOL result = FALSE;
    Invoice *inv = [[Invoice alloc]init];
    CGRect pageSize;
    
    pageSize = CGRectMake(0, 0, 850, 1100);
    NSString *fileName = [NSString stringWithFormat:@"%@",inv.projectName];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)lastObject];
    NSString *pdfPathWithFileName = [documentDirectory stringByAppendingPathComponent:fileName];
    
    [self generatePDF:pdfPathWithFileName pageSize:pageSize];
    [self drawBackgroundWithPageSize:pageSize];
    [self drawTextWithPageSize:pageSize];
    
    return result;
}

+ (void)generatePDF:(NSString *)filePath pageSize:(CGRect)pageSize
{
    UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 850, 1100), nil);
    
    
}

+ (void)drawBackgroundWithPageSize:(CGRect)pageSize
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, pageSize.size.width, pageSize.size.height);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor]CGColor]);
    CGContextFillRect(context, rect);
}

+ (void) drawTextWithPageSize:(CGRect)pageSize
{
    NSString *text = [[NSString alloc]init];
    text = @"XXXXXXXXXXXXXXXXX";
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect textRect = CGRectMake(10, 10, 100, 100);
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:14];
    [text drawInRect:textRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
}


@end
