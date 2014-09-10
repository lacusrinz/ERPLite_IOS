//
//  MainViewController.swift
//  ERPLite
//
//  Created by RInz on 14-6-7.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ContactsViewControllerDelegate {
    
    var contacts = [Contacts]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func BtnContacts(sender : UIButton) {
        GetContacts()
    }
    
    @IBAction func BtnEvent(sender : UIButton) {
        performSegueWithIdentifier("goToEvents", sender: self)
    }
    
    @IBAction func BtnCalendar(sender : UIButton) {
        performSegueWithIdentifier("goToCalendar", sender: self)
    }
    
    @IBAction func BtnMessage(sender : UIButton) {
        performSegueWithIdentifier("goToMessage", sender: self)
    }
    
    @IBAction func BtnSetting(sender : UIButton) {
        performSegueWithIdentifier("goToSetting", sender: self)
    }
    
    func GetContacts(){
        let userDefaultes = NSUserDefaults.standardUserDefaults()
        var access_token = userDefaultes.stringForKey("access_token")
        var accessToken = NSString(string: "Bearer " + access_token!)

        var url_contacts = kContactListURL
        
        var manager = AFHTTPRequestOperationManager()
        manager.requestSerializer.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        manager.GET(url_contacts,
            parameters: nil,
            success: {
                (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                var response = JSONValue(responseObject)
                var count = response["count"].integer
                
                for var index = 0; index<count; ++index{
                    var url_contacts = NSURL(string: kGetSignedUrl.stringByAppendingString(response["results"][index]["avatar"].string!))
                    var requestAvatar = ASIHTTPRequest(URL: url_contacts);
                    requestAvatar.addRequestHeader("Authorization", value: accessToken)
                    requestAvatar.startSynchronous()
                    var responseAvatar = requestAvatar.responseString()

                    var contact = Contacts()
                    contact.name = response["results"][index]["name"].string
                    contact.avatarURL = responseAvatar
                    contact.thumbnailURL = response["results"][index]["thumbnailURL"].string
                    self.contacts.append(contact)
                }
                SVProgressHUD.dismiss()
                self.performSegueWithIdentifier("goToContacts", sender: self)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
                SVProgressHUD.showErrorWithStatus(error.localizedDescription)
            })
        SVProgressHUD.show()
    }


    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "goToContacts"){
            let navigationController = segue.destinationViewController as UINavigationController
            let contactsViewController = navigationController.viewControllers[0] as ContactsViewController
            contactsViewController.delegate = self
            contactsViewController.contacts = self.contacts
        }
    }
    
    func ContactsViewControllerDidBack(controller: ContactsViewController){
        dismissViewControllerAnimated(false, completion:nil)
        contacts = [Contacts]()
    }

}
