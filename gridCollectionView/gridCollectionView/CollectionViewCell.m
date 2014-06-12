//
//  CollectionViewCell.m
//  gridCollectionView
//
//  Created by Howard Livingston on 6/8/14.
//  Copyright (c) 2014 Howard Livingston. All rights reserved.
//

//This file is to establish the twitterPost custom cell


#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


//Plugging in the values for the cell which will coincide with the custom object from twitterPostInfo
-(void)refreshCollectionCell:(NSString*)collectionText collectionImage:(UIImage*)collectionImage;
{
    
    
    [_friendImage.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [_friendImage.layer setBorderWidth: 10.0];
    
    self.friendImage.image = collectionImage;
    self.friendTextLabel.text = collectionText;
   



}
@end
