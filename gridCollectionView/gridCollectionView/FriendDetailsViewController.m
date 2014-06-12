//
//  FriendDetailsViewController.m
//  gridCollectionView
//
//  Created by Howard Livingston on 6/8/14.
//  Copyright (c) 2014 Howard Livingston. All rights reserved.
//

//This file is for the friends Detail View Controller

#import "FriendDetailsViewController.h"

@interface FriendDetailsViewController ()

@end

@implementation FriendDetailsViewController


- (void)viewDidLoad
{
    
    //Creating a border around the image
    [friendsDetailImage.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [friendsDetailImage.layer setBorderWidth: 14.0];
    
    //Plugging in the values to the elements/outlets in the friends detail view
    friendsDetailLabel.text = self.friendDetailInfo.twitterFriendsName;
    friendsDetailImage.image = self.friendDetailInfo.twitterFriendsImage;

    [super viewDidLoad];
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}





@end
