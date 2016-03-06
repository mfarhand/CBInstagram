//
//  CBIMediaUserEntity.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/5/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIMediaUserEntity.h"

@implementation CBIMediaUserEntity

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        
        self.standard_resolution_url = [[self.images objectForKey:@"standard_resolution"] objectForKey:@"url"];
        self.text = [self.caption objectForKey:@"text"];
        self.username = [[dict objectForKey:@"user"] objectForKey:@"username"];
        
    }
    return self;
}

@end
