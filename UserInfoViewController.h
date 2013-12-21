//
//  UserInfoViewController.h
//  Freelance_assistant
//
//  Created by Rich Allen on 14/12/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *userFirstName;
@property (weak, nonatomic) IBOutlet UITextField *userSurname;
- (IBAction)donButton:(id)sender;

@end
