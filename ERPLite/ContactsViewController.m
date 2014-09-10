//
//  ContactsViewController.m
//  ERPLite
//
//  Created by RInz on 14-6-13.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import "ContactsViewController.h"
#import "Constants.h"
#import "Contacts.h"
#import "ContactCell.h"
#import "QuartzCore/QuartzCore.h"

#import <ASIFormDataRequest.h>
#import <SVProgressHUD.h>
#import <JSONKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import <AFNetworking/AFNetworking.h>


@implementation ContactsViewController

- (void)viewDidLoad{
    self.contactsTableView.delegate = self;
    self.contactsTableView.dataSource = self;
}

- (IBAction)Back:(id)sender {
    [self.delegate ContactsViewControllerDidBack:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ContactCell";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if (cell == nil) {
//        cell = [[ImageTextCell alloc]
//                initWithStyle:UITableViewCellStyleSubtitle
//                reuseIdentifier:CellIdentifier];
//    }
    
    Contacts *contact = [self.contacts objectAtIndex:indexPath.row];
    cell.nameLabel.text = contact.name;
    cell.dateLabel.text = contact.modifiedDate;
    
    cell.avatarThumbnail.layer.cornerRadius = cell.avatarThumbnail.frame.size.height/2;
    cell.avatarThumbnail.layer.masksToBounds = YES;
    cell.avatarThumbnail.contentMode = UIViewContentModeScaleAspectFit;//UIViewContentModeScaleAspectFill
    [cell.avatarThumbnail setImageWithURL:[NSURL URLWithString:contact.avatarURL]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"goToContactDetail" sender:self];
}

- (void)MapViewControllerDidBack:(MapViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
