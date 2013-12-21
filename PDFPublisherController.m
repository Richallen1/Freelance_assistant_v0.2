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

+(NSString *)PublishPDFWithData:(NSArray *)invoiceRows withClientDetails:(NSDictionary *)invDetails forClient:(Client *)clientSelected
{
    
    //Store Class Vars
    invoiceRowData = [[NSArray alloc]init];
    invoiceClientData = [[NSDictionary alloc]init];
    
    invoiceRowData = invoiceRows;
    invoiceClientData = invDetails;
    NSLog(@"Row Data Count: %lu",(unsigned long)[invoiceRowData count]);
    NSLog(@"Client Data Count: %@",invoiceClientData);
    
    NSString *fileName = [[NSString alloc]init];
    fileName = [self getPDFFileNameWithProjInfo:[invDetails objectForKey:@"invoiceNumber"]];

    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    [self drawLabelsWithInvoiceDetails:invDetails andSelectedClient:clientSelected];
    //[self drawLogo];
    
    int xOrigin = 50;
    int yOrigin = 300;
    
    CGPoint startPointForTable = CGPointMake(xOrigin, yOrigin);
    CGPoint nextPoint = CGPointMake(0, 0);
    
    //Draw Header
    nextPoint = [self createRowAt:startPointForTable data1:@"Qty" data2:@"Description" data3:@"Price" data4:@"VAT" data5:@"Total"];
    
    if (invoiceRowData.count > 0) {
        for (int i = 0; i <= invoiceRowData.count-1; i++)
        {
            NSString *qtyString = [[NSString alloc] init];
            qtyString = [invoiceRowData[i] objectForKey:@"Qty"];
            NSString *descString = [[NSString alloc] init];
            descString = [invoiceRowData[i] objectForKey:@"Desc"];
            NSString *priceString = [[NSString alloc]init];
            priceString = [invoiceRowData[i] objectForKey:@"subTotal"];
            NSString *vatString = [[NSString alloc]init];
            vatString = [invoiceRowData[i] objectForKey:@"VAT"];
            NSString *totalString = [[NSString alloc]init];
            totalString = [invoiceRowData[i] objectForKey:@"Total"];
            
            //Draw Row
            nextPoint = [self createRowAt:nextPoint data1:qtyString data2:descString data3:priceString data4:vatString data5:totalString];
        }
    }
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();

    return fileName;
}
+(NSString*)getPDFFileName
{
    NSString* fileName = @"Invoice.PDF";
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    NSLog(@"%@", pdfFileName);
    
    return pdfFileName;
    
}
+(NSString*)getPDFFileNameWithProjInfo:(NSString *)file
{
    NSString* fileName = [NSString stringWithFormat:@"%@.PDF",file];
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    NSLog(@"%@", pdfFileName);
    
    return pdfFileName;
    
}

+(void)drawPDF:(NSString*)fileName
{
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    
    [self drawLogo];
    int xOrigin = 50;
    int yOrigin = 300;
    CGPoint startPointForTable = CGPointMake(xOrigin, yOrigin);
    //Draw Header
    [self createRowAt:startPointForTable data1:@"Qty" data2:@"Description" data3:@"Price" data4:@"VAT" data5:@"Total"];
    
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
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
    NSLog(@"Drawing Text: %@", textToDraw);
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
+(void)drawLabelsWithInvoiceDetails:(NSDictionary *)dict andSelectedClient:(Client *)clientSelected
{
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"InvoiceView" owner:nil options:nil];
    UIView* mainView = [objects objectAtIndex:0];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    for (UIView* view in [mainView subviews]) {
        if([view isKindOfClass:[UILabel class]])
        {
            UILabel* label = (UILabel*)view;
            //Recpient Name
            if (label.tag == 1) {
                if (label.text != nil) {
                label.text = clientSelected.company;
                }
            }
            //Recpient Addr
            if (label.tag == 2) {
                if (label.text != nil) {
                label.text = clientSelected.address;
                }
            }
            //Recpient City
            if (label.tag == 3) {
                if (label.text != nil) {
                label.text = clientSelected.city;
                }
            }
            //Recpient Postcode
            if (label.tag == 4) {
                if (label.text != nil) {
                label.text = clientSelected.zip;
                }
            }
            //Invoicer Name
            if (label.tag == 5) {
                if (label.text != nil) {
                label.text = [defaults objectForKey:@"User_Name"];
                }
            }
            //Invoicer Addr
            if (label.tag == 6) {
                if (label.text != nil) {
                label.text = [defaults objectForKey:@"User_Address_1"];
                }
            }
            //Invoicer City
            if (label.tag == 7) {
                if (label.text != nil) {
                label.text = @"Addlestone" ;
                }
                
            }
            //Invoicer Postcode
            if (label.tag == 8) {
                if (label.text != nil) {
                label.text = [defaults objectForKey:@"User_Address_2"] ;
                }
            }
            //Proj Name
            if (label.tag == 9) {
                if (label.text != nil) {
                label.text = [dict objectForKey:@"projectName"];
                }
            }
            //inv number
            if (label.tag == 10) {
                if (label.text != nil) {
                label.text = [dict objectForKey:@"invoiceNumber"];
                }
            }
            //inv terms
            if (label.tag == 11) {
                if (label.text != nil) {
                    NSString *str =[NSString stringWithFormat:@"Payment due in %@ days",[defaults objectForKey:@"inv_term_period"]];
                label.text = str;
                }
            }
            //inv AC number
            if (label.tag == 12) {
                if (label.text != nil) {
                    NSString *str = [NSString stringWithFormat:@"Account Number: %@", [defaults objectForKey:@"User_Account_Number"]];
                    label.text = str;
                }
            }
            //inv Sort
            if (label.tag == 13) {
                if (label.text != nil) {
                    NSString *str = [NSString stringWithFormat:@"Sort Code: %@", [defaults objectForKey:@"User_Sort_Code"]];
                    label.text = str;
                }
            }
            //inv notes
            if (label.tag == 14) {
                if (label.text != nil) {
                    NSString *str = [NSString stringWithFormat:@"VAT Number: %@", [defaults objectForKey:@"User_VAT"]];
                    label.text = str;
                }
            }
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
+(CGPoint)createRowAt:(CGPoint)origin
                data1:(NSString *)col1
                data2:(NSString *)col2
                data3:(NSString *)col3
                data4:(NSString *)col4
                data5:(NSString *)col5;
{
    int coloumnHeight = 30;
    CGPoint returnValue = CGPointMake(origin.x, origin.y);
    
    
    //Start Col Line
    CGPoint from = CGPointMake(origin.x, origin.y);
    CGPoint to = CGPointMake(origin.x, origin.y +coloumnHeight);
    [self drawLineFromPoint:from toPoint:to];

    CGRect frame1 = CGRectMake(from.x, from.y, 40, -30);
    [self drawText:col1 inFrame:frame1];
    
    //End Qty Line
    CGPoint newXVar = CGPointMake(origin.x+40, origin.y);
    CGPoint from2 = CGPointMake(newXVar.x, origin.y);
    CGPoint to2 = CGPointMake(newXVar.x, origin.y + coloumnHeight);
    [self drawLineFromPoint:from2 toPoint:to2];
    
    CGRect frame2 = CGRectMake(from2.x, from2.y, 180, -30);
    [self drawText:col2 inFrame:frame2];
    
    //End Desc Line
    CGPoint newXVar2 = CGPointMake(newXVar.x+180, origin.y);
    CGPoint from3 = CGPointMake(newXVar2.x, origin.y);
    CGPoint to3 = CGPointMake(newXVar2.x, origin.y + coloumnHeight);
    [self drawLineFromPoint:from3 toPoint:to3];
    
    CGRect frame3 = CGRectMake(from3.x, from3.y, 100, -30);
    [self drawText:col3 inFrame:frame3];
    
    //End Price Line
    CGPoint newXVar3 = CGPointMake(newXVar2.x+100, origin.y);
    CGPoint from4 = CGPointMake(newXVar3.x, origin.y);
    CGPoint to4 = CGPointMake(newXVar3.x, origin.y + coloumnHeight);
    [self drawLineFromPoint:from4 toPoint:to4];
    
    CGRect frame4 = CGRectMake(from4.x, from4.y, 100, -30);
    [self drawText:col4 inFrame:frame4];
    
    //End VAT Line
    CGPoint newXVar4 = CGPointMake(newXVar3.x+100, origin.y);
    CGPoint from5 = CGPointMake(newXVar4.x, origin.y);
    CGPoint to5 = CGPointMake(newXVar4.x, origin.y + coloumnHeight);
    [self drawLineFromPoint:from5 toPoint:to5];
    
    CGRect frame5 = CGRectMake(from5.x, from5.y, 100, -30);
    [self drawText:col5 inFrame:frame5];
    
    //End TOTAL Line
    CGPoint newXVar5 = CGPointMake(newXVar4.x+70, origin.y);
    CGPoint from6 = CGPointMake(newXVar5.x, origin.y);
    CGPoint to6 = CGPointMake(newXVar5.x, origin.y + coloumnHeight);
    [self drawLineFromPoint:from6 toPoint:to6];
    
    //Top Lines
    [self drawLineFromPoint:from toPoint:from2];
    [self drawLineFromPoint:from2 toPoint:from3];
    [self drawLineFromPoint:from3 toPoint:from4];
    [self drawLineFromPoint:from4 toPoint:from5];
    [self drawLineFromPoint:from5 toPoint:from6];
    //Bottom Lines
    [self drawLineFromPoint:to toPoint:to2];
    [self drawLineFromPoint:to2 toPoint:to3];
    [self drawLineFromPoint:to3 toPoint:to4];
    [self drawLineFromPoint:to4 toPoint:to5];
    [self drawLineFromPoint:to5 toPoint:to6];
    returnValue = to;
    return returnValue;
}

@end
