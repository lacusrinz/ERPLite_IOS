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
#import "ImageTextCell.h"
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
//    [self getContacts];
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
    ImageTextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if (cell == nil) {
//        cell = [[ImageTextCell alloc]
//                initWithStyle:UITableViewCellStyleSubtitle
//                reuseIdentifier:CellIdentifier];
//    }
    
    Contacts *contact = [self.contacts objectAtIndex:indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.modifiedDate;
    cell.imageView.contentMode = UIViewContentModeCenter;
//    NSLog(@"%@: %@",contact.name,contact.thumbnailURL);
    [cell.imageView setImageWithURL:[NSURL URLWithString:contact.thumbnailURL]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"goToContactDetail" sender:self];
}

//- (void)getContacts{
//    NSMutableArray *contacts = [NSMutableArray arrayWithCapacity:10];
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    NSString *access_token = [userDefaultes stringForKey:@"access_token"];
//    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@", access_token];
//    
//    NSURL *url_contacts = [NSURL URLWithString:kContactListURL];
//    ASIHTTPRequest *requestContacts = [ASIHTTPRequest requestWithURL:url_contacts];
//    [requestContacts addRequestHeader:@"Authorization" value:accessToken];
//    [requestContacts startSynchronous];
//    NSData *responseData = [requestContacts responseData ];
//    
//    JSONDecoder *jd = [[JSONDecoder alloc] init];
//    NSDictionary *result = [jd objectWithData:responseData];
//    if ([result objectForKey:@"status_code"] != nil) {
//    }
//    else{
//        for (NSDictionary *json in result[@"results"]){
//            Contacts *contact = [[Contacts alloc]init];
//            contact.name = json[@"name"];
//            contact.avatarURL = json[@"avatar"];
//            
//            NSURL *url_thumbnail = [NSURL URLWithString:[kGetSignedUrl stringByAppendingString:json[@"thumbnail"]]];
//            ASIHTTPRequest *requestThumbnail = [ASIHTTPRequest requestWithURL:url_thumbnail];
//            [requestThumbnail addRequestHeader:@"Authorization" value:accessToken];
//            [requestThumbnail startSynchronous];
//            NSData *thumbnailData = [requestThumbnail responseData];
//            
////            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
////            [manager.requestSerializer setValue:accessToken forHTTPHeaderField:@"Authorization"];
////            [manager GET:[kGetSignedUrl stringByAppendingString:json[@"thumbnail"]]
////                     parameters:nil
////                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
////                         NSLog(@"JSON: %@", responseObject);
////                     }
////                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////                         NSLog(@"Error: %@", error);
////            }];
//            
//            contact.thumbnailURL = [[NSString alloc] initWithData:thumbnailData encoding:NSASCIIStringEncoding];
////            NSLog(@"%@: %@",contact.name,contact.thumbnailURL);
//            contact.detailURL = json[@"url"];
//            contact.modifiedDate = json[@"modifiedDate"];
//            [contacts addObject:contact];
//        }
//        self.contacts = contacts;
//    }
//    [self.contactsTableView reloadData];
//}

- (IBAction)AddContact:(id)sender {
}
@end
