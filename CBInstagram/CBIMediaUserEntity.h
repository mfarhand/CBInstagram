//
//  CBIMediaUserEntity.h
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/5/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CBIMediaUserEntity : JSONModel

@property (nonatomic,strong) NSString *attribution;
@property (nonatomic,strong) NSDictionary *caption;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *first_name;
@property (nonatomic,strong) NSString *full_name;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSDictionary *images;
@property (nonatomic,strong) NSString *standard_resolution_url;

@end
