//
//  twitterPostInfo.m
//  gridCollectionView
//
//  Created by Howard Livingston on 6/10/14.
//  Copyright (c) 2014 Howard Livingston. All rights reserved.
//


//This file is to establish the twitterPost custom object

#import "twitterPostInfo.h"

@implementation twitterPostInfo

@synthesize twitterFriendsName,twitterFriendsImage;


//Establishing the values and setting it up to copy the info from the Twitter feed
-(id)initWithPostInfo:(NSString*)friendName friendImage:(UIImage*)friendImage;
{

    if ((self = [super init]))
    
        {
            twitterFriendsName = [friendName copy];
            twitterFriendsImage = [friendImage copy];
            
        }
    
    
    
    return self;
    
}


@end
