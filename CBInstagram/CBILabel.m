//
//  CBILabel.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBILabel.h"

@implementation CBILabel

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (self.preferredMaxLayoutWidth != bounds.size.width) {
        self.preferredMaxLayoutWidth = bounds.size.width;
        [self setNeedsUpdateConstraints];
    }}

@end
