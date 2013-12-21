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
#import "invoiceViewController.h"


@implementation PDFViewController
@synthesize fileName;
@synthesize filePath;
@synthesize client;
@synthesize projectName;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"PDF Filename: %@", fileName);
    [self showPDFFileWithFile:filePath];
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
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 58, 768, 1000)];
    NSURL *url = [NSURL fileURLWithPath:pdfFileName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
}
- (IBAction)cancelSend:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma Mail Room
- (IBAction)showMailPicker:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
        // The device can send email.
    {
        [self displayMailComposerSheet];
    }
    else
        // The device can not send email.
    {
        //Create Alert View
        UIAlertView *msgAlert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your device not configured to send mail." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [msgAlert show];
    }
}
#pragma mark - Compose Mail/SMS
// -------------------------------------------------------------------------------
//	displayMailComposerSheet
//  Displays an email composition interface inside the application.
//  Populates all the Mail fields.
// -------------------------------------------------------------------------------
- (void)displayMailComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
    
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *subject = [NSString stringWithFormat:@"Invoice from %@", [defaults objectForKey:@"User_Name"]];
	[picker setSubject:subject];
	
    NSArray *toRecipients;
	// Set up recipients
    if (client.email) {
        toRecipients = [NSArray arrayWithObject:client.email];
    }
	else
    {
        toRecipients = [NSArray arrayWithObject:@""];
    }
    NSArray *bccRecipients = [NSArray arrayWithObject:[defaults objectForKey:@"User_Email"]];
	
	[picker setToRecipients:toRecipients];
    [picker setBccRecipients:bccRecipients];

    // Attach the invoice to the email
	NSData *myData = [NSData dataWithContentsOfFile:filePath];
	[picker addAttachmentData:myData mimeType:@"application/pdf" fileName:fileName];
    NSLog(@"%@", filePath);

	
	// Fill out the email body text
	NSString *emailBody = [NSString stringWithFormat:@"Please find attached my invoice for %@", projectName];
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Delegate Methods
// -------------------------------------------------------------------------------
//	mailComposeController:didFinishWithResult:
//  Dismisses the email composition interface when users tap Cancel or Send.
//  Proceeds to update the message field with the result of the operation.
// -------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    UIAlertView *msgAlert;
    feedbackMsg = [[NSString alloc]init];
    	// Notifies users about errors associated with the interface
    	switch (result)
    	{
    		case MFMailComposeResultCancelled:
    			feedbackMsg = @"Result: Mail sending canceled";
    			break;
    		case MFMailComposeResultSaved:
    			feedbackMsg = @"Result: Mail saved";
    			break;
    		case MFMailComposeResultSent:
    			feedbackMsg = @"Result: Mail sent";
                msgAlert = [[UIAlertView alloc]initWithTitle:@"SENT!" message:@"Your invoice has been sent." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    			break;
    		case MFMailComposeResultFailed:
    			feedbackMsg = @"Result: Mail sending failed";
                msgAlert = [[UIAlertView alloc]initWithTitle:@"Oops...." message:@"Your invoice failed to send. Please check your network settings and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    			break;
    		default:
    			feedbackMsg = @"Result: Mail not sent";
    			break;
    	}
    NSLog(@"%@", feedbackMsg);
    if (msgAlert != nil) {
        [msgAlert show];
    }
	[self dismissViewControllerAnimated:YES completion:NULL];
}
@end
