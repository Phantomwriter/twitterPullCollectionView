//
//  twitterPostInfo.h
//  gridCollectionView
//
//  Created by Howard Livingston on 6/10/14.
//  Copyright (c) 2014 Howard Livingston. All rights reserved.
//

//This file is to establish the twitterPost custom object

#import <Foundation/Foundation.h>

@interface twitterPostInfo : NSObject

{
    
    NSString *twitterFriendsName;
    UIImage*twitterFriendsImage;
   

    
    
}

@property(strong, nonatomic)UIImage *twitterFriendsImage;
@property(strong,nonatomic)NSString *twitterFriendsName;

//Custom method
-(id)initWithPostInfo:(NSString*)friendName friendImage:(UIImage*)friendImage;
@end
