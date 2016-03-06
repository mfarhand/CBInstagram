//
//  CIRequestManager.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  Clinet_ID  @"d12770e225be4403adc596f5099f4235"
#define  Redirect_URL  @"https://instagram.com"

#define KAUTHURL @"https://api.instagram.com/oauth/authorize/"
#define kAPIURl @"https://api.instagram.com/v1/users/"
#define KCLIENTID @"d12770e225be4403adc596f5099f4235"
#define KCLIENTSERCRET @"76f3f0a3553a4ca0b8351343be0dbdf0"
#define kREDIRECTURI @"https://instagram.com"
@interface CBIRequestManager : NSObject

+(instancetype)sharedManager;
-(void)getTokenWithInstagramWithVerifier:(NSString*)verifier withCompletion:(void (^)(NSData * response,NSError * error))result;
-(void)getAllOfImagesWithToken:(NSString*)token WithCompletion:(void (^)(NSArray * response,NSError * error))result;
@end
