//
//  Contacts.h
//  ERPLite
//
//  Created by RInz on 14-6-14.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contacts : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *modifiedDate;
@property (copy, nonatomic) NSString *avatarURL;
@property (copy, nonatomic) NSString *thumbnailURL;
@property (copy, nonatomic) NSString *detailURL;

@end
