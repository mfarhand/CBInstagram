//
//  CBIDownloder.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/5/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIDownloder.h"
static void * CBIProgressChanged = &CBIProgressChanged;

@interface CBIDownloder()
{
    
}
@property (nonatomic,strong)NSURLSessionDownloadTask *downloadTask;
@end

@implementation CBIDownloder

@synthesize delegate;
@synthesize tokenIdentifire;
-(instancetype)initWithrequestToDownloadWithToken:(NSString *)token
{
    self = [super init];
    if (self) {
        self.tokenIdentifire = token;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSProgress *localProgress = nil;
        [localProgress addObserver:self
                        forKeyPath:@"fractionCompleted"
                           options:NSKeyValueObservingOptionNew
                           context:CBIProgressChanged];
        NSURL *URL = [NSURL URLWithString:token];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        self.downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            [self.delegate downloadDidContinueWithProgress:downloadProgress forToken:self.tokenIdentifire];
            //            NSLog(@"\n\n Progress : %@",downloadProgress);
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            //
            NSLog(@"\n\n DownloadFinished for Token : %@",self.tokenIdentifire);
            
            if (!error || error == nil) {
                [self.delegate downloadDidFinnishedWithToken:self.tokenIdentifire withFileName:[response suggestedFilename]];
                
            }
            else
            {
                [self.delegate downloadDidFailedWithToken:self.tokenIdentifire withError:error];
            }
        }];
    }
    return self;
}

-(void)startDownload
{
    [self.downloadTask resume];
}

-(void)suspendDownload
{
    [self.downloadTask suspend];
}


@end





