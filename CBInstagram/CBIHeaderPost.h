//
//  CBIHeaderPost.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBIDownloadeQueueHandler.h"
#import "CBIMediaUserEntity.h"
@interface CBIHeaderPost : UITableViewCell<CBIDownloadQueueDelegate>
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) IBOutlet UILabel *timeStamp;
@property (strong, nonatomic) CBIMediaUserEntity * metaInfo;

-(void)configure;
@end
