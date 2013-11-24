//
//  InvoicesOverviewViewController.h
//  Freelance_assistant
//
//  Created by Richard Allen on 24/11/2013.
//  Copyright (c) 2013 Rich Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoicesOverviewViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *invTableView;


@end
