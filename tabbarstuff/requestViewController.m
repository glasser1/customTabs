//
//  requestViewController.m
//  tabbarstuff
//
//  Created by itadmin on 2/16/14.
//  Copyright (c) 2014 itadmin. All rights reserved.
//

#import "requestViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#define BOSS_CAT @"100002171073663"
#define TEST_USER @"100007922251250"
#define ERIC_I @"17508335"

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

- (NSDictionary *)parseURLParams:(NSString *)query
{
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs)
    {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        
        [params setObject:[[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                   forKey:[[kv objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    return params;
}

- (void)viewDidLoad
{
    
    
    
////////////////////////NOT WORKING CODE/////////////////////////////////////
    
    
    //code to invite users to join the app.....except it isn't working.  haha.  don't know why yet.
    /*
    NSMutableDictionary* params =   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"17508335", @"to", // user ID - in this case, Eric
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
    
    
    NSDictionary *parameters = @{@"to":TEST_USER};
    
    [FBWebDialogs presentRequestsDialogModallyWithSession:nil
                                                  message:[NSString stringWithFormat:@"You've received an challenge at Piste+Off!"]
                                                    title:nil
                                               parameters:parameters
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
     {
         if(error)
         {
             NSLog(@"Some errorr: %@", [error description]);
             UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Invitiation Sending Failed" message:@"Unable to send inviation at this Moment, please make sure your are connected with internet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
             [alrt show];
         }
         else
         {
             if (![resultURL query])
             {
                 return;
             }
             
             NSDictionary *params = [self parseURLParams:[resultURL query]];
             NSMutableArray *recipientIDs = [[NSMutableArray alloc] init];
             for (NSString *paramKey in params)
             {
                 if ([paramKey hasPrefix:@"to["])
                 {
                     [recipientIDs addObject:[params objectForKey:paramKey]];
                 }
             }
             if ([params objectForKey:@"request"])
             {
                 NSLog(@"Request ID: %@", [params objectForKey:@"request"]);
             }
             if ([recipientIDs count] > 0)
             {
                 //[self showMessage:@"Sent request successfully."];
                 //NSLog(@"Recipient ID(s): %@", recipientIDs);
                 UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Invitation(s) sent successfuly!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alrt show];
             }
             
         }
     }friendCache:nil];

///////////////////////WORKING CODE////////////////////////////////////////
    
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
    
    /*
    
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

    */

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
