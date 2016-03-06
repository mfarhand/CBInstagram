//
//  CBIHeaderPost.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIHeaderPost.h"
#import "CBIImageCache.h"
@implementation CBIHeaderPost
@synthesize avatar;
@synthesize userName;
@synthesize timeStamp;
- (void)awakeFromNib {
    // Initialization code
    self.avatar.layer.cornerRadius = 20;
    self.avatar.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)configure
{
    
    
    self.userName.text = self.metaInfo.username;
    self.timeStamp.text = @"5H";
    UIImage * tempImage =  [[CBIImageCache sharedInstance]getImageByToken:self.metaInfo.profile_picture];
    if(tempImage) {
        self.avatar.image = tempImage;
    }
    else
    {
        [[CBIDownloadeQueueHandler sharedInstance]requestToDownloadWithToken:self.metaInfo.profile_picture];
    }
}

-(void)downloadDidFinishedWithToken:(NSString *)token withFileName:(NSString *)filename
{
    if ([self.metaInfo.profile_picture isEqualToString:token]) {
        self.avatar.image = [[CBIImageCache sharedInstance]getImageByToken:token];
    }
}

@end
