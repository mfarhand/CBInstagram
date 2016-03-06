//
//  CBISelfProvider.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBISelfProvider.h"

@implementation CBISelfProvider
+(instancetype)sharedInstance
{
    static CBISelfProvider * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}
@end
