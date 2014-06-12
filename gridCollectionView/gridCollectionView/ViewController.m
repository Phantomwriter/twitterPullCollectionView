//
//  ViewController.m
//  gridCollectionView
//
//  Created by Howard Livingston on 6/8/14.
//  Copyright (c) 2014 Howard Livingston. All rights reserved.
//


// This file is for the main view

//Related classes
#import "ViewController.h"
#import "FriendDetailsViewController.h"
#import "CollectionViewCell.h"
#import "twitterPostInfo.h"


//Important Frameworks
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    //Initilize the twitter post object
    twitterPosts = [[NSMutableArray alloc] init];
    
    //Refresh Twitter on load
    [self refreshTwitter];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - Twitter functionality

//Want to be able to call this more than once
-(void)refreshTwitter
{
    
    //need to add this so we can access the account store objects and methods. We can also access the Facebook fees with this as well
    ACAccountStore *accountStore= [[ACAccountStore alloc] init];
    if (accountStore != nil)
        
    {

        //first, what type of account are we lookng for?
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        if (accountType != nil)
        {
            //Alert that the tweets are being loaded
            alert =[[UIAlertView alloc] initWithTitle:@"Loading Tweets Now"
                                              message:nil
                                             delegate:nil
                                    cancelButtonTitle:@"Cancel"
                                    otherButtonTitles:nil];
            activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            activityIndicator.center = CGPointMake(150, 350);
            activityIndicator.hidesWhenStopped = YES;
            [self.view addSubview:activityIndicator];
            [activityIndicator startAnimating];
            [alert show];
            
            
            
            
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
             {
                 
                 if (granted)
                 {
                     NSLog(@"Starting to get info");
                     //SUCCESS
                     //information populated is in an array. In order to access information from the array, we need to build something to do that
                     NSArray *twitterAccount = [accountStore accountsWithAccountType:accountType];
                     if (twitterAccount != nil)
                         
                        {
                         
                            ACAccount * currentAccount = [twitterAccount objectAtIndex:0];
                                if (currentAccount != nil)
                                {
                                    //create a string to hold the twitter request info
                                    //if you want specific info, instead of user_timelone.json, use a parameter from the online docs found here
                             
                             
                                    NSString *requestString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/friends/list.json?count=20"];
                             
                                    NSLog(@"got the stuff...waiting to serialize");
                             
                                    //create a social framework request object
                                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:requestString] parameters:nil];
                                        if(request != nil)
                                        {
                                 
                                            [request setAccount:currentAccount];
                                 
                                            //perform the request..using code block
                                            [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                     
                                                                                
                                                if ((error == nil) && ([urlResponse statusCode] == 200))
                                                {
                                                    NSArray *twitterFeed = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                                                    //NSLog(@"%@", [[twitterFeed objectAtIndex:0] description]);
                                    
                                    
                                                    //create a for-loop to loop through all the posts. It is a dictionary this time, ot an object, so we must specify valueForKey
                                    
                                                    for (int i=0; i<[[twitterFeed valueForKey:@"users"]count]; i++)
                                                    {
                                                        //This object, that was cretaed below, hold the posts
                                                        twitterPostInfo *postInfo =[self createPostInfoFromDictionary:[[twitterFeed    valueForKey:@"users"]objectAtIndex:i]];
                                        
                                                            if (postInfo != nil)
                                                                {
                                                                    
                                                                    //Putting the posts into the object
                                                                    [twitterPosts addObject:postInfo];
                                            
                                            
                                                                }
                                        
                                                        NSLog(@"here's the friend info: %@", twitterPosts);
                                                        
                                                    }
                                                    
                                                                                        
                                                }       //Grand Central Dispatch "one time" call
                                                        dispatch_async(dispatch_get_main_queue(), ^
                                                        {
                                                            [friendCollectionView reloadData];
                                        
                                                        });
                                                   
                                                }];
                                                
                                                  
                                        }
                                            }
                                        
                                    }
                                }
                                else
                                             {
                                                 //Load warning
                                                 [noLoadWarning dismissWithClickedButtonIndex:0 animated:YES];
                                                 UIAlertView *deniedAccess = [[UIAlertView alloc]initWithTitle:@"An Error Has Occured" message:@"Unable to make a connection" delegate:self cancelButtonTitle:@"I'll try something different" otherButtonTitles:nil];
                                                 [deniedAccess show];
                                             }


                                        }];
            
                                    [noLoadWarning dismissWithClickedButtonIndex:0 animated:YES];

                                 [alert dismissWithClickedButtonIndex:0 animated:YES];
                                 [activityIndicator stopAnimating];
                             }
                                }
                                                                       }
                                                                       

//
-(twitterPostInfo*)createPostInfoFromDictionary:(NSDictionary*)postDictionary
{
    //parsing the data
     NSString *userNameString =[NSString stringWithFormat:@"%@",[postDictionary valueForKey:@"screen_name"]];
    image =[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[postDictionary valueForKey:@"profile_image_url_https"]]];
   
    
    
    twitterImage =[[UIImage alloc] initWithData:image];
    
    //attaching info to custom method from twitterPostInfoClass
    twitterPostInfo *postDetails = [[twitterPostInfo alloc]initWithPostInfo:userNameString friendImage:twitterImage];
    
    
    
    return postDetails;
}




#pragma mark - Segues

//This segue is to move between pic view controllers
-(IBAction)done:(UIStoryboardSegue *)segue
{
    
    
    
}




//Transitioning segues for the table cell view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 
    
        FriendDetailsViewController*friendDetails = segue.destinationViewController;
    
    if (friendDetails !=nil)
    
    {
        //Info is coming from the cell
        UICollectionViewCell *cell = (UICollectionViewCell*)sender;
        
        //Establishing the path to the cell
        NSIndexPath *indexPath = [friendCollectionView indexPathForCell:cell];
        
        //Establishing the info object
        twitterPostInfo *friendInfoForVC = [twitterPosts objectAtIndex:indexPath.row];
        
        //Declaring its final destination
        friendDetails.friendDetailInfo = friendInfoForVC;
        
        
    }
    
    
}

#pragma mark - Cells Structure


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    
    return [twitterPosts count];
    
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //
    CollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    if (collectionCell != nil)
    
    {
        //putting all the info in the cells
        twitterPostInfo *friendInfo =[twitterPosts objectAtIndex:indexPath.row];
        
        [collectionCell refreshCollectionCell:friendInfo.twitterFriendsName collectionImage:friendInfo.twitterFriendsImage];

    }
    
    NSLog(@"Deque string now");
    
       return collectionCell;
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
