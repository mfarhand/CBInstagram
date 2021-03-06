//
//  CBIMediaUserEntity.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/5/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIMediaUserEntity.h"
#import <DateTools.h>
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
        self.profile_picture = [[dict objectForKey:@"user"] objectForKey:@"profile_picture"];
        self.my_profile_picture = [dict objectForKey:@"profile_picture"];
        self.width = [[self.images objectForKey:@"standard_resolution"]valueForKey:@"width"];
        self.height = [[self.images objectForKey:@"standard_resolution"]valueForKey:@"height"];

        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.created_time.doubleValue];
        self.finaltimeStamp = [date shortTimeAgoSinceNow];
        
    }
    return self;
}

@end
