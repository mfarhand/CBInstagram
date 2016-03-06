//
//  CBIGridViewController.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBIDownloadeQueueHandler.h"
#import "CBIMediaUserEntity.h"
@interface CBIGridViewController : UICollectionViewController<CBIDownloadQueueDelegate>
@property (nonatomic,strong) NSMutableArray * posts;

@end
