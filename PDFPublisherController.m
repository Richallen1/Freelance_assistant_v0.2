//
//  PDFPublisherController.m
//  pdfGenerator
//
//  Created by Richard Allen on 07/12/2013.
//  Copyright (c) 2013 Richard Allen. All rights reserved.
//

#import "PDFPublisherController.h"

@interface PDFPublisherController ()
{
    CGRect pageSize;
}
@end

@implementation PDFPublisherController

- (BOOL)publishPdfWithInvoice:(Invoice *)data
{
    BOOL result = FALSE;
    Invoice *inv = [[Invoice alloc]init];
    
    pageSize = CGRectMake(0, 0, 850, 1100);
    NSString *fileName = [NSString stringWithFormat:@"%@",inv.projectName];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)lastObject];
    NSString *pdfPathWithFileName = [documentDirectory stringByAppendingPathComponent:fileName];
    
    [self generatePDF:pdfPathWithFileName];
    [self drawBackground];
    [self drawText];
    
    return result;
}

- (void)generatePDF:(NSString *)filePath
{
    UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 850, 1100), nil);
    
    
}

- (void)drawBackground
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, pageSize.size.width, pageSize.size.height);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor]CGColor]);
    CGContextFillRect(context, rect);
}

- (void) drawText
{
    NSString *text = [[NSString alloc]init];
    text = @"XXXXXXXXXXXXXXXXX";
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect textRect = CGRectMake(10, 10, 100, 100);
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:14];
    [text drawInRect:textRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
}
@end
