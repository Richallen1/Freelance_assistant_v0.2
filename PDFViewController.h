//
//  PDFViewController.h
//  iOSPDFRenderer
//
//  Created by Tope on 21/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"
#import <MessageUI/MessageUI.h>

@interface PDFViewController : UIViewController <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>
{
    NSString *feedbackMsg;

}

@property (nonatomic, strong) Client *client;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *projectName;

-(void)showPDFFileWithFile:(NSString *)file;

- (IBAction)showMailPicker:(id)sender;
@end
