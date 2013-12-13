//
//  PDFViewController.m
//  iOSPDFRenderer
//
//  Created by Tope on 21/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PDFViewController.h"
#import "CoreText/CoreText.h"
#import "PDFPublisherController.h"
#import "SendInvoiceViewController.h"


@implementation PDFViewController
@synthesize fileName;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    
    CGRect rect = CGRectMake(0, -60, 300, 300);
    self.view.bounds = rect;
    
    
    NSLog(@"%@", fileName);
    [self showPDFFileWithFile:fileName];

    [super viewDidLoad];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)showPDFFileWithFile:(NSString *)file
{
    NSString* pdfFileName = file;
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    
    NSURL *url = [NSURL fileURLWithPath:pdfFileName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
}
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"Send Invoice Segue"]) {
//        [segue.destinationViewController initVariblesWithFileName:fileName andClient:];
//    }
//
//}

@end
