//
//  ShareViewController.m
//  tabbarstuff
//
//  Created by itadmin on 1/26/14.
//  Copyright (c) 2014 itadmin. All rights reserved.
//

#import "ShareViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)share:(id)sender {
        
        // Check if the Facebook app is installed and we can present the share dialog
        FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
        params.link = [NSURL URLWithString:@"http://linktoappsomehow.com"];
        params.name = @"I just completed a run using Piste+Off!";
        params.caption = @"Join Piste+Off and receive special offers for doing what you love.";
        params.picture = [NSURL URLWithString:@"http://i.imgur.com/g3Qc1HN.png"];
        params.description = [NSString stringWithFormat:@"I just climbed %d feet!", 10];//nScore];
        
        
        // If the Facebook app is installed and we can present the share dialog
        if ([FBDialogs canPresentShareDialogWithParams:params]) {
            
            // Present share dialog
            [FBDialogs presentShareDialogWithLink:params.link
                                             name:params.name
                                          caption:params.caption
                                      description:params.description
                                          picture:params.picture
                                      clientState:nil
                                          handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                              if(error) {
                                                  // An error occurred, we need to handle the error
                                                  // See: https://developers.facebook.com/docs/ios/errors
                                                  NSLog([NSString stringWithFormat:@"Error publishing story: %@", error.description]);
                                              } else {
                                                  // Success
                                                  NSLog(@"result %@", results);
                                              }
                                          }];
            
            // If the Facebook app is NOT installed and we can't present the share dialog
        } else {
            // FALLBACK: publish just a link using the Feed dialog
            
            // Put together the dialog parameters
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"I just completed a run using Piste+Off!", @"name",
                                           @"Join Piste+Off and receive special offers for doing what you love.", @"caption",
                                           [NSString stringWithFormat:@"I just climbed %d feet!", 10], @"description",
                                           @"http://www.linktositeordownload.com", @"link",
                                           @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                           nil];
            
            // Show the feed dialog
            [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                                   parameters:params
                                                      handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                          if (error) {
                                                              // An error occurred, we need to handle the error
                                                              // See: https://developers.facebook.com/docs/ios/errors
                                                              NSLog([NSString stringWithFormat:@"Error publishing story: %@", error.description]);
                                                          } else {
                                                              if (result == FBWebDialogResultDialogNotCompleted) {
                                                                  // User canceled.
                                                                  NSLog(@"User cancelled.");
                                                              } else {
                                                                  // Handle the publish feed callback
                                                                  NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                                  
                                                                  if (![urlParams valueForKey:@"post_id"]) {
                                                                      // User canceled.
                                                                      NSLog(@"User cancelled.");
                                                                      
                                                                  } else {
                                                                      // User clicked the Share button
                                                                      NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                      NSLog(@"result %@", result);
                                                                  }
                                                              }
                                                          }
                                                      }];
        }
}

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
