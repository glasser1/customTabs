//
//  ViewController.m
//  tabbarstuff
//
//  Created by itadmin on 1/12/14.
//  Copyright (c) 2014 itadmin. All rights reserved.
//

#import "ViewController.h"


@interface ViewController (){
    NSArray *tabArray;
    NSArray *viewArray;
}

@end

@implementation ViewController

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //NSLog(@"didSelectItem: %d", item.tag);
    [self activateView:item.tag];
}

- (void)viewDidLoad
{
    self.myTabBar.delegate = self;
    UIImage *tabBarBackground = [UIImage imageNamed:@"tabBarBackground.png"];
    UIImage *tabBarSelectedItem = [UIImage imageNamed:@"tabBarSelectedItem.png"];
    [self.myTabBar setBackgroundImage:tabBarBackground];
    [self.myTabBar setSelectionIndicatorImage:tabBarSelectedItem];
    [self.myTabBar setSelectedItem:self.item1];
    
    
    tabArray = [[NSArray alloc] initWithObjects:_item1,_item2,_item3, nil];
    viewArray = [[NSArray alloc] initWithObjects:_friendsView, _tournamentView, _statsView, nil];
    [self activateView:_friendsView.tag];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)activateView:(NSInteger) index{
    for (NSInteger i=0; i<viewArray.count; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        if (i==index) {
            [view setHidden:NO];
        }
        else{
            [view setHidden:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
