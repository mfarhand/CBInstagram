//
//  CBICollectionViewCell.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBIImageCache.h"
#import "CBIDownloadeQueueHandler.h"
#import "CBIMediaUserEntity.h"
@interface CBICollectionViewCell : UICollectionViewCell<CBIDownloadQueueDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *thumbnail;
@property (strong ,nonatomic) CBIMediaUserEntity  * postEntity;


-(void)configureCell;
@end
