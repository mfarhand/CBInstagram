//
//  CBIHomeViewController.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBIDownloadeQueueHandler.h"
#import "CBIMediaUserEntity.h"

@interface CBIHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *CBIPostTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (nonatomic,strong) NSMutableArray * posts;


@end
