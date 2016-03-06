//
//  CBISelfProvider.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBIMediaUserEntity.h"
@interface CBISelfProvider : NSObject

+(instancetype)sharedInstance;

@property (nonatomic,strong) CBIMediaUserEntity * selfInformation;
@end
