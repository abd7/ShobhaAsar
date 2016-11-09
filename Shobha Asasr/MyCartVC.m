//
//  MyCartVC.m
//  Shobha Asasr
//
//  Created by Ascra on 10/26/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "MyCartVC.h"
#import "MyCartVCCell.h"
#import "AppDelegate.h"
#import "UIButton+Badge.h"

@interface MyCartVC ()
{
    NSInteger myCartIndexVal;
}

@end

@implementation MyCartVC
@synthesize myCartCollection;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDel=[[UIApplication sharedApplication]delegate];
    
    if([self.myCartImageArray count]>0)
    {
        cart_btn.badgeValue=[NSString stringWithFormat:@"%lu", (unsigned long)self.myCartImageArray.count];
    }
    
    myCartCollection.dataSource=self;
    myCartCollection.delegate=self;
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.myCartImageArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    myCartIndexVal=indexPath.row;
    
     MyCartVCCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"mycart" forIndexPath:indexPath];
    
    
    NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[appDel.cartListCount objectAtIndex:indexPath.row]]]];
    
 
    
    cell.myCart_imageView.image=[UIImage imageWithData:imageData];;
    

    cell.myCart_view.layer.borderColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0].CGColor;
    
    cell.myCart_view.layer.borderWidth=1.5;
    
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // myCartIndexVal=indexPath.row;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}



- (IBAction)onTapMyCart_closeBtn:(id)sender {
    
    [appDel.cartListCount removeObjectAtIndex:myCartIndexVal];
    //[myCartClose_btn removeFromSuperview];
    [myCartCollection reloadData];
}

- (IBAction)onTapLeftMenu_btn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
  
}
@end
