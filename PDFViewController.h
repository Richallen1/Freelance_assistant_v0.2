//
//  PDFViewController.h
//  iOSPDFRenderer
//
//  Created by Tope on 21/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"

@interface PDFViewController : UIViewController

@property (nonatomic, strong) Client *client;
@property (nonatomic, strong) NSString *fileName;
-(void)showPDFFile;
-(void)showPDFFileWithFile:(NSString *)file;

@end
