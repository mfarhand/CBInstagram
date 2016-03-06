//
//  CBIDownloadeQueueHandler.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/5/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBIDownloder.h"
#import "GCDMulticastDelegate.h"


@protocol CBIDownloadQueueDelegate <NSObject>

-(void)downloadDidFinishedWithToken:(NSString*)token withFileName:(NSString*)filename;

@optional
-(void)downloadContintueWithProgress:(NSProgress*)progress forToken:(NSString*)token;

@end


@interface CBIDownloadeQueueHandler : NSObject<CBIDownloaderDelegate>
{
    id multicastDelegate;
    dispatch_queue_t moduleQueue;
    void *moduleQueueTag;

}


@property (nonatomic,strong) NSMutableArray * mainDownloadQueue;
@property (nonatomic,strong) NSMutableArray * currentDownloadQueue;
@property (nonatomic,strong) NSMutableDictionary * tokensDict;
@property (nonatomic,strong) NSOperationQueue * operationQueue;
@property (nonatomic,strong) id <CBIDownloadQueueDelegate>delegate;
@property (readonly) dispatch_queue_t moduleQueue;
@property (readonly) void *moduleQueueTag;


+(instancetype)sharedInstance;
-(void)requestToDownloadWithToken:(NSString*)token;


- (void)addDelegate:(id)aDelegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)aDelegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)aDelegate;

@end
