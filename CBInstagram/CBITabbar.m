//
//  CBITabbar.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBITabbar.h"

@implementation CBITabbar

-(void)drawRect:(CGRect)rect
{
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, self.bounds.size.height)];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    [blurView setEffect:blurEffect];
    [self insertSubview:blurView atIndex:0];
}

@end
