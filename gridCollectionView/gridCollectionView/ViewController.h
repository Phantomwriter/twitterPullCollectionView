//
//  ViewController.h
//  gridCollectionView
//
//  Created by Howard Livingston on 6/8/14.
//  Copyright (c) 2014 Howard Livingston. All rights reserved.
//

#import <UIKit/UIKit.h>

//

// This file is for the main view

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

{
    
    //The collection view outlet
    IBOutlet UICollectionView *friendCollectionView;
   
    //The twitter Post array
    NSMutableArray *twitterPosts;
    
    
    //Variable for my Twitter Image
    NSData *image;
    UIImage *twitterImage;
    
    
    //Variable for my Alerts
    UIAlertView *alert;
    UIActivityIndicatorView *activityIndicator;
    UIAlertView *noLoadWarning;

}









@end
