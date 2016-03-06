//
//  CBICollectionViewCell.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBICollectionViewCell.h"

@implementation CBICollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)configureCell
{
    self.thumbnail.image = [[CBIImageCache sharedInstance] getImageByToken:self.postEntity.standard_resolution_url];
    
    if (!self.thumbnail.image) {
        
        [[CBIDownloadeQueueHandler sharedInstance]requestToDownloadWithToken:self.postEntity.standard_resolution_url];
        [[CBIDownloadeQueueHandler sharedInstance]addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
    }

}

-(void)downloadDidFinishedWithToken:(NSString *)token withFileName:(NSString *)filename
{
    
    if ([self.postEntity.standard_resolution_url isEqualToString:token]) {
        
        self.thumbnail.image = [[CBIImageCache sharedInstance]getImageByToken:token];
    }
}


@end
