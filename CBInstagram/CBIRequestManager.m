//
//  CIRequestManager.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIRequestManager.h"
#import "CBIMediaUserEntity.h"

@implementation CBIRequestManager
+(instancetype)sharedManager
{
    static CBIRequestManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
    
}

-(instancetype)init
{
    
    self = [super init];
    if (self) {
        // do something
    }
    
    return self;
}



-(void)getTokenWithInstagramWithVerifier:(NSString*)verifier withCompletion:(void (^)(NSData * response,NSError * error))result
{
    
    NSString *data = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",Clinet_ID,KCLIENTSERCRET,kREDIRECTURI,verifier];
    
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/access_token"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (error) {
                                          // Handle error...
                                          return;
                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
                                      
                                      NSString* body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      NSLog(@"Response Body:\n%@\n", body);
                                      result(data,nil);
                                  }];
    [task resume];
    
}


-(void)getAllOfImagesWithToken:(NSString*)token WithCompletion:(void (^)(NSArray * response,NSError * error))result;
{
    NSURL * mediaURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@",token]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:mediaURL]
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (error) {
                                          // Handle error...
                                          return;
                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
                                      
                                      
                                      NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                      
                                      
                                      NSMutableArray * finalImagesURL = [[NSMutableArray alloc]init];
                                      NSMutableArray *images = [responseDict objectForKey:@"data"];
                                      for (NSDictionary * dict in images) {
                                          
                                          
                                          CBIMediaUserEntity * temp = [[CBIMediaUserEntity alloc]initWithDictionary:dict error:nil];
                                          //                                          [finalImagesURL addObject:[[[dict objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"]];
                                          
                                          [finalImagesURL addObject:temp];
                                      }
                                      
                                      result(finalImagesURL,nil);
                                      
                                  }];
    
    [task resume];
}



-(void)getSelfInformationWithToken:(NSString*)token WithCopletion:(void (^)(CBIMediaUserEntity* selfInfo))result
{
    
    
    NSURL * selfURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/?access_token=%@",token]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:selfURL]
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (error) {
                                          // Handle error...
                                          return;
                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
                                      
                                      
                                      NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                      
                                          CBIMediaUserEntity * selfInformation = [[CBIMediaUserEntity alloc]initWithDictionary:[responseDict objectForKey:@"data"] error:nil];
   
                                      
                                      result(selfInformation);
                                      
                                  }];
    
    [task resume];
    
}


@end
