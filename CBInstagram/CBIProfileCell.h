//
//  CBIProfileCell.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBIMediaUserEntity.h"
#import "CBIImageCache.h"
@interface CBIProfileCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) CBIMediaUserEntity * myInfo;

-(void)setup;
@end
