//
//  PDFPublisherController.m
//  pdfGenerator
//
//  Created by Richard Allen on 07/12/2013.
//  Copyright (c) 2013 Richard Allen. All rights reserved.
//

#import "PDFPublisherController.h"
#import "CoreText/CoreText.h"

@implementation PDFPublisherController

+(BOOL)PublishPDFWithData:(NSArray *)invoiceRows withClientDetails:(NSDictionary *)invDetails
{
    BOOL sucess = FALSE;
    
    if (!invoiceRows) {
        //No Rows
        return sucess;
    }
    if (!invDetails) {
        //No Details
        return sucess;
    }
    //Store Class Vars
    invoiceRowData = [[NSArray alloc]init];
    invoiceClientData = [[NSDictionary alloc]init];
    
    invoiceRowData = invoiceRows;
    invoiceClientData = invDetails;
    NSLog(@"Row Data Count: %lu",(unsigned long)[invoiceRowData count]);
    NSLog(@"Client Data Count: %@",invoiceClientData);
    
    return sucess;
}

+(void)drawPDF:(NSString*)fileName
{
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    [self drawText:@"Hello World" inFrame:CGRectMake(0, 0, 300, 50)];
    
    [self drawLabels];
    [self drawLogo];
    
    int xOrigin = 50;
    int yOrigin = 300;
    
    int rowHeight = 50;
    int columnWidth = 120;
    
    int numberOfRows = 7;
    int numberOfColumns = 4;
    
    [self drawTableAt:CGPointMake(xOrigin, yOrigin) withRowHeight:rowHeight andColumnWidth:columnWidth andRowCount:numberOfRows andColumnCount:numberOfColumns];
    
    [self drawTableDataAt:CGPointMake(xOrigin, yOrigin) withRowHeight:rowHeight andColumnWidth:columnWidth andRowCount:numberOfRows andColumnCount:numberOfColumns];
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}


+(void)drawPDFOld:(NSString*)fileName
{
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    [self drawText:@"Hello World" inFrame:CGRectMake(0, 0, 300, 50)];
    
    CGPoint from = CGPointMake(0, 0);
    CGPoint to = CGPointMake(200, 300);
    [PDFPublisherController drawLineFromPoint:from toPoint:to];
    
    UIImage* logo = [UIImage imageNamed:@"ray-logo.png"];
    CGRect frame = CGRectMake(20, 100, 300, 60);
    
    [PDFPublisherController drawImage:logo inRect:frame];
    
    [self drawLabels];
    [self drawLogo];
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}

+(void)drawText
{
    
    NSString* textToDraw = @"Hello World";
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    // Prepare the text using a Core Text Framesetter
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    
    CGRect frameRect = CGRectMake(0, 0, 300, 50);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 100);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
}

+(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.2, 0.2, 0.2, 0.3};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    
    CGContextSetStrokeColorWithColor(context, color);
    
    
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
}


+(void)drawImage:(UIImage*)image inRect:(CGRect)rect
{
    
    [image drawInRect:rect];
    
}

+(void)drawText:(NSString*)textToDraw inFrame:(CGRect)frameRect
{
    
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    // Prepare the text using a Core Text Framesetter
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, frameRect.origin.y*2);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    CGContextTranslateCTM(currentContext, 0, (-1)*frameRect.origin.y*2);
    
    
    CFRelease(frameRef);
    //CFRelease(stringRef);
    CFRelease(framesetter);
}


+(void)drawLabels
{
    
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"InvoiceView" owner:nil options:nil];
    
    UIView* mainView = [objects objectAtIndex:0];
    
    for (UIView* view in [mainView subviews]) {
        if([view isKindOfClass:[UILabel class]])
        {
            UILabel* label = (UILabel*)view;
            
            
            [self drawText:label.text inFrame:label.frame];
        }
    }
    
}


+(void)drawLogo
{
    
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"InvoiceView" owner:nil options:nil];
    
    UIView* mainView = [objects objectAtIndex:0];
    
    for (UIView* view in [mainView subviews]) {
        if([view isKindOfClass:[UIImageView class]])
        {
            
            UIImage* logo = [UIImage imageNamed:@"tempLogo.jpg"];
            [self drawImage:logo inRect:view.frame];
        }
    }
    
}


+(void)drawTableAt:(CGPoint)origin
     withRowHeight:(int)rowHeight
    andColumnWidth:(int)columnWidth
       andRowCount:(int)numberOfRows
    andColumnCount:(int)numberOfColumns

{

    for (int i = 0; i <= numberOfRows; i++) {
        
        int newOrigin = origin.y + (rowHeight*i);
        
        
        CGPoint from = CGPointMake(origin.x, newOrigin);
        CGPoint to = CGPointMake(origin.x + (numberOfColumns*columnWidth), newOrigin);
        
    
        
        [self drawLineFromPoint:from toPoint:to];
        
        
    }
    //Draw Columns
    
    //Start Col Line
    CGPoint from = CGPointMake(origin.x, origin.y);
    CGPoint to = CGPointMake(origin.x, origin.y +(numberOfRows*rowHeight));
    [self drawLineFromPoint:from toPoint:to];
    
    //End Qty Line
    CGPoint newXVar = CGPointMake(origin.x+40, origin.y);
    CGPoint from2 = CGPointMake(newXVar.x, origin.y);
    CGPoint to2 = CGPointMake(newXVar.x, origin.y +(numberOfRows*rowHeight));
    [self drawLineFromPoint:from2 toPoint:to2];
    
    //End Desc Line
    CGPoint newXVar2 = CGPointMake(newXVar.x+180, origin.y);
    CGPoint from3 = CGPointMake(newXVar2.x, origin.y);
    CGPoint to3 = CGPointMake(newXVar2.x, origin.y +(numberOfRows*rowHeight));
    [self drawLineFromPoint:from3 toPoint:to3];
    
    //End Price Line
    CGPoint newXVar3 = CGPointMake(newXVar2.x+80, origin.y);
    CGPoint from4 = CGPointMake(newXVar3.x, origin.y);
    CGPoint to4 = CGPointMake(newXVar3.x, origin.y +(numberOfRows*rowHeight));
    [self drawLineFromPoint:from4 toPoint:to4];
    
    //End VAT Line
    CGPoint newXVar4 = CGPointMake(newXVar3.x+80, origin.y);
    CGPoint from5 = CGPointMake(newXVar4.x, origin.y);
    CGPoint to5 = CGPointMake(newXVar4.x, origin.y +(numberOfRows*rowHeight));
    [self drawLineFromPoint:from5 toPoint:to5];
    
    //End TOTAL Line
    CGPoint from6 = CGPointMake((numberOfColumns*columnWidth)+51, origin.y);
    CGPoint to6 = CGPointMake((numberOfColumns*columnWidth)+51, origin.y +(numberOfRows*rowHeight));
    [self drawLineFromPoint:from6 toPoint:to6];
    
}

+(void)drawTableDataAt:(CGPoint)origin
         withRowHeight:(int)rowHeight
        andColumnWidth:(int)columnWidth
           andRowCount:(int)numberOfRows
        andColumnCount:(int)numberOfColumns
{
//    int padding = 10;
//    
//    NSArray* headers = [NSArray arrayWithObjects:@"Quantity", @"Description", @"Unit price", @"Total", nil];
//    NSArray* invoiceInfo1 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
//    NSArray* invoiceInfo2 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
//    NSArray* invoiceInfo3 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
//    NSArray* invoiceInfo4 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
//    
//    NSArray* allInfo = [NSArray arrayWithObjects:headers, invoiceInfo1, invoiceInfo2, invoiceInfo3, invoiceInfo4, nil];
//    
//    for(int i = 0; i < [allInfo count]; i++)
//    {
//        NSArray* infoToDraw = [allInfo objectAtIndex:i];
//        
//        for (int j = 0; j < numberOfColumns; j++)
//        {
//            
//            int newOriginX = origin.x + (j*columnWidth);
//            int newOriginY = origin.y + ((i+1)*rowHeight);
//            
//            CGRect frame = CGRectMake(newOriginX + padding, newOriginY + padding, columnWidth, rowHeight);
//            
//            
//            [self drawText:[infoToDraw objectAtIndex:j] inFrame:frame];
//        }
//        
//    }
    
    
    
    
}

@end
