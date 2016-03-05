//
//  CBIDownloder.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/5/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol CBIDownloaderDelegate <NSObject>

-(void)downloadDidFinnishedWithToken:(NSString*)token withFileName:(NSString*)filename;
-(void)downloadDidFailedWithToken:(NSString*)token withError:(NSError*)error;
-(void)downloadDidContinueWithProgress:(NSProgress*)progress forToken:(NSString*)token;

@end

@interface CBIDownloder : NSObject

-(instancetype)initWithrequestToDownloadWithToken:(NSString*)token;
-(void)startDownload;
-(void)suspendDownload;

@property (nonatomic,strong) NSString * tokenIdentifire;
@property (nonatomic,strong) id <CBIDownloaderDelegate> delegate;

@end
