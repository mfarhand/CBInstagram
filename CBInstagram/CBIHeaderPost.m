//
//  CBIHeaderPost.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIHeaderPost.h"

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

@end
