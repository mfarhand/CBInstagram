//
//  CBIImageCache.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIImageCache.h"

@implementation CBIImageCache
+(instancetype)sharedInstance
{
    static CBIImageCache * sharedInstance = nil;
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
        self.mainCacheDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(UIImage *)getImageByToken:(NSString *)token

{
    
    
    if (!token) {
        return nil;
    }
    if ([self.mainCacheDic objectForKey:token]) {
        UIImage * tempImage = [self.mainCacheDic objectForKey:token];
        return tempImage;
    }
    NSString *JPEGfilename = [[NSURL URLWithString:token] lastPathComponent];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//m_nImageIndex
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:JPEGfilename];
    //    UIImage * temp  = [[UIImage alloc]initWithContentsOfFile:savedImagePath];
    NSData *data = [NSData dataWithContentsOfFile:savedImagePath];
    UIImage *temp = [UIImage imageWithData:data];
    
    if (temp) {
        
        [self.mainCacheDic setObject:temp forKey:token];
        return temp;
    }
    else
    {
        return nil;
    }
    
}

-(void)setImage:(NSData *)data ByToken:(NSString *)token
{
    
    NSString *JPEGfilename = [[NSURL URLWithString:token] lastPathComponent];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//m_nImageIndex
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:JPEGfilename];
    BOOL result =  [data writeToFile:savedImagePath atomically:YES];
    if (!result) {
        NSLog(@"Error in saving Image");
    }
}

@end
