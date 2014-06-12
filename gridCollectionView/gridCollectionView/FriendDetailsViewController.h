//
//  FriendDetailsViewController.h
//  gridCollectionView
//
//  Created by Howard Livingston on 6/8/14.
//  Copyright (c) 2014 Howard Livingston. All rights reserved.
//

//This file is for the friends detail view controller


#import <UIKit/UIKit.h>
#import "twitterPostInfo.h"
@interface FriendDetailsViewController : UIViewController

{
    
    IBOutlet UILabel *friendsDetailLabel;
    IBOutlet UIImageView *friendsDetailImage;


}

//Declring the custom method
@property(nonatomic, strong)twitterPostInfo *friendDetailInfo;


@end
