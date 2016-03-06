//
//  CBILoginViewController.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBILoginViewController.h"
#import "CBIHomeViewController.h"
#import "CBIRequestManager.h"
#import <MRProgress.h>
#import "CBIGridViewController.h"
@interface CBILoginViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CBILoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=code",Clinet_ID,Redirect_URL];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    self.title = @"Login";
    
}



- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([[[request URL] host] isEqualToString:@"instagram.com"]) {
        NSString* verifier = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"]) {
                verifier = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (verifier) {

            [[CBIRequestManager sharedManager]getTokenWithInstagramWithVerifier:verifier withCompletion:^(NSData *response, NSError *error) {
                //
                
                NSString * token ;
                NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                if (responseDict) {
                    token = [responseDict objectForKey:@"access_token"];
                    
                    [[CBIRequestManager sharedManager]getAllOfImagesWithToken:token WithCompletion:^(NSArray *response, NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UITabBarController * tempTabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"CBITabbar"];
                            ((CBIHomeViewController*)((UINavigationController*)tempTabbar.viewControllers.firstObject).viewControllers.firstObject).posts =[response mutableCopy];
                            
                            
                            ((CBIGridViewController*)((UINavigationController*)tempTabbar.viewControllers[1]).viewControllers.firstObject).posts =[response mutableCopy];

                            
                            [self presentViewController:tempTabbar animated:YES completion:nil];
                            
                        });
                    }];
                    
                }
                
            }];
        } else {
            // ERROR!
        }
        
        return NO;
    }
    return YES;
}

@end
