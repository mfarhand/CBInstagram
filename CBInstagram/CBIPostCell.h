//
//  CBIPostCell.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBIDownloadeQueueHandler.h"
#import "CBIImageCache.h"
#import <MRProgress.h>
#import "CBIMediaUserEntity.h"

@interface CBIPostCell : UITableViewCell<CBIDownloadQueueDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *postImage;

@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) IBOutlet UILabel *caption;
@property (strong, nonatomic) IBOutlet MRCircularProgressView *progressView;

@property (strong ,nonatomic) NSMutableArray * urls;
@property (strong ,nonatomic) CBIMediaUserEntity  * postEntity;


-(void)configureCell;
@end