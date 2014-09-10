//
//  ContactCell.h
//  ERPLite
//
//  Created by RInz on 14-8-12.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
