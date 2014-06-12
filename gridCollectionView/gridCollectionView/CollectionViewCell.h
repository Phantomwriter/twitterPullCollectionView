//
//  CollectionViewCell.h
//  gridCollectionView
//
//  Created by Howard Livingston on 6/8/14.
//  Copyright (c) 2014 Howard Livingston. All rights reserved.
//


//This file is to establish the twitterPost custom cell


#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

{



}

@property(nonatomic, strong)IBOutlet UILabel *friendTextLabel;
@property(nonatomic, strong)IBOutlet UIImageView *friendImage;

//Establishing the custom cell 
-(void)refreshCollectionCell:(NSString*)collectionText collectionImage:(UIImage*)collectionImage;
@end
