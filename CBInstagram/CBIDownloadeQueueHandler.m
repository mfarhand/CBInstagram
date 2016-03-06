//
//  CBIDownloadeQueueHandler.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/5/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIDownloadeQueueHandler.h"

@interface CBIDownloadeQueueHandler ()

@property (nonatomic,strong) NSURLSession * session;


@end


@implementation CBIDownloadeQueueHandler
@synthesize session;
@synthesize mainDownloadQueue;
@synthesize operationQueue;
@synthesize delegate;
@synthesize moduleQueue =_moduleQueue;
@synthesize moduleQueueTag = _moduleQueueTag;
+(instancetype)sharedInstance
{
    static CBIDownloadeQueueHandler * sharedInstance= nil;
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
        
        const char *moduleQueueName = [[self moduleName] UTF8String];
        moduleQueue = dispatch_queue_create(moduleQueueName, NULL);
        moduleQueueTag = &moduleQueueTag;
        dispatch_queue_set_specific(moduleQueue, moduleQueueTag, moduleQueueTag, NULL);
        self.session = [NSURLSession sharedSession];
        self.mainDownloadQueue = [[NSMutableArray alloc]init];
        self.currentDownloadQueue = [[NSMutableArray alloc]init];
        self.tokensDict = [[NSMutableDictionary alloc]init];
        self.operationQueue = [NSOperationQueue mainQueue];
        multicastDelegate = [[GCDMulticastDelegate alloc] init];
        
    }
    return self;
}


-(void)requestToDownloadWithToken:(NSString *)token
{
    if ([self shouldDownloadItemWithToken:token]) {
        CBIDownloder * downloader =  [[CBIDownloder alloc]initWithrequestToDownloadWithToken:token];
        downloader.delegate = self;
        [self.mainDownloadQueue addObject:downloader];
        [self.tokensDict setObject:downloader forKey:token];
    }
    [self checkQueue];
}

-(void)checkQueue
{
    
    if (self.currentDownloadQueue.count == 0) {
        [(CBIDownloder*)self.mainDownloadQueue.firstObject startDownload];
    }
}

-(BOOL)shouldDownloadItemWithToken:(NSString*)token
{
    // Looing for this token in cache directory :) _Mohi
    
    if ([self.tokensDict objectForKey:token]) {
        return NO;
    }
    return YES;
}

- (NSString *)moduleName
{
    // Override me (if needed) to provide a customized module name.
    // This name is used as the name of the dispatch_queue which could aid in debugging.
    
    return NSStringFromClass([self class]);
}


#pragma marks CBIDownloder Delegate

-(void)downloadDidContinueWithProgress:(NSProgress *)progress forToken:(NSString *)token
{
    [multicastDelegate downloadContintueWithProgress:progress forToken:token];
}

-(void)downloadDidFinnishedWithToken:(NSString *)token withFileName:(NSString *)filename
{
    [multicastDelegate downloadDidFinishedWithToken:token withFileName:filename];
    [self.mainDownloadQueue removeObject:[self.tokensDict objectForKey:token]];
    [self checkQueue];
    
}

-(void)downloadDidFailedWithToken:(NSString *)token withError:(NSError *)error
{
    [self.mainDownloadQueue removeObject:[self.tokensDict objectForKey:token]];
    [self.currentDownloadQueue removeAllObjects];
    [self checkQueue];
}

#pragma mark GCDMulticast Delegate

#pragma mark delegate methodes

-(void)addDelegate:(id)aDelegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    
    dispatch_block_t block = ^{
        [multicastDelegate addDelegate:aDelegate delegateQueue:delegateQueue];
    };
    
    if (dispatch_get_specific(moduleQueueTag))
        block();
    else
        dispatch_async(moduleQueue, block);
}

- (void)removeDelegate:(id)aDelegate delegateQueue:(dispatch_queue_t)delegateQueue synchronously:(BOOL)synchronously
{
    dispatch_block_t block = ^{
        [multicastDelegate removeDelegate:aDelegate delegateQueue:delegateQueue];
    };
    
    if (dispatch_get_specific(_moduleQueueTag))
        block();
    else if (synchronously)
        dispatch_sync(_moduleQueue, block);
    else
        dispatch_async(_moduleQueue, block);
    
}
- (void)removeDelegate:(id)aDelegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    // Synchronous operation (common-case default)
    
    [self removeDelegate:aDelegate delegateQueue:delegateQueue synchronously:YES];
}

- (void)removeDelegate:(id)aDelegate
{
    // Synchronous operation (common-case default)
    
    [self removeDelegate:aDelegate delegateQueue:NULL synchronously:YES];
}

@end
