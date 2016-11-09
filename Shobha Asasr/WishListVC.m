//
//  WishListVC.m
//  Shobha Asasr
//
//  Created by Ascra on 10/26/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "WishListVC.h"
#import "WishListCells.h"
#import "AppDelegate.h"
#import "UIButton+Badge.h"

@interface WishListVC ()
{
    NSInteger indexval;
}

@end

@implementation WishListVC
@synthesize wishlistCV,wishListvcArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDel=[[UIApplication sharedApplication] delegate];
    
    if([wishListvcArray count]>0)
    {
        wishList_btn.badgeValue=[NSString stringWithFormat:@"%lu", (unsigned long)wishListvcArray.count];
    }
    
    
    wishlistCV.dataSource=self;
    wishlistCV.delegate=self;
    
    
   NSLog(@"--%lu",(unsigned long)appDel.wishListCount.count);
    NSLog(@"--%@",appDel.wishListCount);

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return wishListvcArray.count;
}



// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WishListCells *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"wishlist" forIndexPath:indexPath];
    
    NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[wishListvcArray objectAtIndex:indexPath.row]]];
   
    cell.wishlistImageView.image=[UIImage imageWithData:imageData];

    cell.wishlistView.layer.borderColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0].CGColor;
    
    cell.wishlistView.layer.borderWidth=1.5;
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    indexval=indexPath.row;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTapLeftMenu_btn:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onTapRemoveWishList:(id)sender {
    
    [appDel.wishListCount removeObjectAtIndex:indexval];
    //[myCartClose_btn removeFromSuperview];
    [wishlistCV reloadData];
}
@end
