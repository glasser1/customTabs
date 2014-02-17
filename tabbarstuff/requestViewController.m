//
//  requestViewController.m
//  tabbarstuff
//
//  Created by itadmin on 2/16/14.
//  Copyright (c) 2014 itadmin. All rights reserved.
//

#import "requestViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface requestViewController ()

@end

@implementation requestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    //code to invite users to join the app.....except it isn't working.  haha.  don't know why yet.
    
    /*NSMutableDictionary* params =   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"17508335", @"to", // Eric
                                     nil];
    
    [FBWebDialogs presentRequestsDialogModallyWithSession:nil
                                                  message:[NSString stringWithFormat:@"You've received an challenge at Piste+Off!"]
                                                    title:@"Piste+Off!"
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // Case A: Error launching the dialog or sending request.
                                                          NSLog(@"Error sending request.");
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // Case B: User clicked the "x" icon
                                                              NSLog(@"User canceled request.");
                                                          } else {
                                                              NSLog(@"Request Sent.");
                                                          }
                                                      }}
                                              friendCache:nil];
     */
    
    
    
    //code to get all friends
    
    /*
     FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        NSArray* friends = [result objectForKey:@"data"];
        NSLog(@"Found: %i friends", friends.count);
        for (NSDictionary<FBGraphUser>* friend in friends) {
            NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
        }
    }];
     */
    
    
    
    //code to get friends that have the app.  maybe use this to "challenge" instead of invite.  to get friends that DON"T have the app, change the is_app_user = 1 to 0
    
    NSString *query = [NSString stringWithFormat:@"SELECT uid, name, pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1"];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    query, @"q",
                                    nil];
    
    FBRequest *request = [FBRequest requestWithGraphPath:@"/fql" parameters:params HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        //do your stuff
        NSLog(@"Friends with app: %@", result);
    }];

    

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
