//
//  ViewController.h
//  tabbarstuff
//
//  Created by itadmin on 1/12/14.
//  Copyright (c) 2014 itadmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITabBarItem *item1;
@property (weak, nonatomic) IBOutlet UITabBarItem *item2;
@property (weak, nonatomic) IBOutlet UITabBarItem *item3;
@property (weak, nonatomic) IBOutlet UITabBar *myTabBar;

@property (weak, nonatomic) IBOutlet UIView *friendsView;
@property (weak, nonatomic) IBOutlet UIView *tournamentView;
@property (weak, nonatomic) IBOutlet UIView *statsView;

@end
