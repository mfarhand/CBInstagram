//
//  CBIImageCache.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CBIImageCache : NSObject

+(instancetype)sharedInstance;
-(UIImage *)getImageByToken:(NSString*)token;
-(void)setImage:(NSData*)data ByToken:(NSString*)token;

@property (strong , nonatomic) NSMutableDictionary * mainCacheDic;


@end
