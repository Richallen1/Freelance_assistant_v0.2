//
//  Postmaster.h
//  Freelance_assistant
//
//  Created by Rich Allen on 12/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Postmaster : NSObject

+(BOOL)SendMailWithFileName:(NSString *)fileName;

+(NSString *)MailChecker;

@end
