//
//  CBIProfileCell.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIProfileCell.h"

@implementation CBIProfileCell

- (void)awakeFromNib {
    // Initialization code
    self.avatar.layer.cornerRadius = 25;
    self.avatar.layer.masksToBounds = YES;
}

-(void)setup
{
    self.username.text = self.myInfo.username;
    self.avatar.image =  [[CBIImageCache sharedInstance] getImageByToken:self.myInfo.standard_resolution_url];
}


@end
