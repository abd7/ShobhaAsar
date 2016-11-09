//
//  ProductDetailViewController.m
//  Shobha Asasr
//
//  Created by AscratechMacmini on 14/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductCollectionViewCell.h"
#import "UIButton+Badge.h"
#import "CartCollectionCell.h"
#import "SimilarProductCell.h"
#import "AppDelegate.h"
#import "MetalCell.h"
#import "DiamondCustomCell.h"
#import "GemstoneCustomCell.h"
#import "CollectionVC.h"

#import "MyCartVC.h"
#import "WishListVC.h"

@interface ProductDetailViewController ()
{
    NSInteger selectedIndexVal;
    MyCartVC *myCartvc;
    WishListVC *myWishvc;
    
}

@end

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation ProductDetailViewController
@synthesize sectionTitlesArray,product_Scroll;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    app = [[UIApplication sharedApplication] delegate];
    
    [self wishListBadgeCheck];
    [self cartListBadgeValCheck];
    
   
    
     collectionviewimgs.backgroundColor = [UIColor clearColor];
    
    [product_Scroll setContentSize:CGSizeMake(0, collectionviewimgs.frame.size.height+similaarProductCV.frame.size.height+290+560)];
    
    
    
    
     arrayforimgs=[[NSMutableArray alloc]init];
     [ arrayforimgs addObject:[UIImage imageNamed:@"PE818.jpg"]];
     [arrayforimgs addObject:[UIImage imageNamed:@"BR673.jpg"]];
     [ arrayforimgs addObject:[UIImage imageNamed:@"ER1782.jpg"]];
     [arrayforimgs addObject:[UIImage imageNamed:@"BR673.jpg"]];
     [ arrayforimgs addObject:[UIImage imageNamed:@"ER1782.jpg"]];
    
   
    nameArray=[[NSMutableArray alloc]init];
    purityArray=[[NSMutableArray alloc]init];
    weightArray=[[NSMutableArray alloc]init];
    
    DaiPieceArrOne=[[NSMutableArray alloc]init];
    DaiPieceArrTwo=[[NSMutableArray alloc]init];
    
    DaiWeightArrOne=[[NSMutableArray alloc]init];
    DaiWeightArrTwo=[[NSMutableArray alloc]init];
    
    gemsPieces1Array=[[NSMutableArray alloc]init];
    gemsWeight1Array=[[NSMutableArray alloc]init];
    
    gemsPieces2Array=[[NSMutableArray alloc]init];
    gemsWeight2Array=[[NSMutableArray alloc]init];
    
    
    sectionTitlesArray=[[NSMutableArray alloc]initWithObjects:@"Metal",@"Daimond",@"Gemstones",nil];
    
   NSMutableDictionary* detailsDic= [[[NSUserDefaults standardUserDefaults]valueForKey:@"productDetails"] objectAtIndex:_indexVal];
    
    
        [purityArray addObject:[detailsDic valueForKey:@"karat"]];
        [weightArray addObject:[detailsDic valueForKey:@"size"]];
        
        [DaiPieceArrOne addObject:[detailsDic objectForKey:@"dia_pcs"]];
        [DaiWeightArrOne addObject:[detailsDic objectForKey:@"dia_wt"]];
        
        [DaiPieceArrTwo addObject:[detailsDic objectForKey:@"dia_pcs"]];
        [DaiWeightArrTwo addObject:[detailsDic objectForKey:@"dia_wt"]];
        
        [gemsPieces1Array addObject:[detailsDic objectForKey:@"pieces"]];
        [gemsWeight1Array addObject:[detailsDic objectForKey:@"weight"]];
    
        [gemsPieces2Array addObject:[detailsDic objectForKey:@"pieces"]];
        [gemsWeight2Array addObject:[detailsDic objectForKey:@"weight"]];
    
        
        

    
    [nameArray addObject:@"Gold"];
    [nameArray addObject:@"Silver"];

    
    ornamentLstTable.delegate=self;
    ornamentLstTable.dataSource=self;
    
    ornamentLstTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    collectionviewimgs.delegate=self;
    collectionviewimgs.dataSource=self;
    
    cartItemsCollection.delegate=self;
    cartItemsCollection.dataSource=self;
    
    similaarProductCV.delegate=self;
    similaarProductCV.dataSource=self;
    
   
    
    [similaarProductCV setShowsHorizontalScrollIndicator:NO];
    [similaarProductCV setShowsVerticalScrollIndicator:NO];
    
    [collectionviewimgs setShowsHorizontalScrollIndicator:NO];
    [collectionviewimgs setShowsVerticalScrollIndicator:NO];
    
    [cartItemsCollection setShowsHorizontalScrollIndicator:NO];
    [cartItemsCollection setShowsVerticalScrollIndicator:NO];
    
    
  
    NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.mainImageArray]]];
   
    proDetails_imageView.image=[UIImage imageWithData:imageData];
    
    styleNoLabel.text=[NSString stringWithFormat:@"Style No. %@",self.productStyleNo];
    
    styleNo.text=[NSString stringWithFormat:@"Style No. %@",self.productStyleNo];;
    
    collectionNameLabel.text=self.productTypeName;
    
    NSLog(@"%@",self.productStyleNo);

}



-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)hideNoCartLabel
{
    if (_cartImageArray.count==0) {
        noCartLabel.hidden=NO;
    }
    else
    {
        noCartLabel.hidden=YES;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [self hideNoCartLabel];
   
//[self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView ==cartItemsCollection) {
        
        return self.cartImageArray.count;
        
    }
    
    else if (collectionView ==  similaarProductCV)
    {
        return arrayforimgs.count;
    }
    else
    {
        return arrayforimgs.count;
    }
    
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == cartItemsCollection) {
        
        CartCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cartCell" forIndexPath:indexPath];
        
        NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.cartImageArray objectAtIndex:indexPath.row]]];
       
        cell.cartImageView.image=[UIImage imageWithData:imageData];
        
    
       
      
       //cell.cellview.layer.borderWidth=1.5;
        
        
        return  cell;
        
    }
    
    else if (collectionView  == similaarProductCV)
    {
       
        
        SimilarProductCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"similarproduct" forIndexPath:indexPath];
        
        cell.similarItemImage.image=[arrayforimgs objectAtIndex:indexPath.row];
        
        cell.similarItemView.layer.borderColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0].CGColor;
        cell.similarItemView.layer.borderWidth=1.5;
        return  cell;

        
    }
    else
    {
       
        ProductCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"imageview" forIndexPath:indexPath];
        
        cell.imgview.image=[arrayforimgs objectAtIndex:indexPath.row];
        
        cell.cellview.layer.borderColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0].CGColor;
        cell.cellview.layer.borderWidth=1.5;
        
       
        
        return  cell;
        
    }
    
   
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -1, tableView.bounds.size.width, 24)];
    [headerView setBackgroundColor:UIColorFromRGB(0x5e3f1c)];
    
    
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, 100, 17)];
    titleLabel.textColor=UIColorFromRGB(0xe8d0a1);
    [titleLabel setFont:[UIFont fontWithName:@"ZapfHumanist601BT-Roman" size:12]];
    
    [headerView addSubview:titleLabel];
   
  
    if (section==0) {
        
        titleLabel.text=@"Metal";
    }
    
    else if (section == 1)
    {
        titleLabel.text=@"Diamond";
    }
    else
    {
        titleLabel.text=@"Gemstone";
        
    }
    
    return headerView;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        
        
        static NSString *simpleTableIdentifier = @"metalCell";
        
        MetalCell *cell = (MetalCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MetalCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.purityOne.text = [purityArray objectAtIndex:indexPath.row];
        cell.weightOne.text = [weightArray objectAtIndex:indexPath.row];
        
        
        [cell setBackgroundColor:UIColorFromRGB(0x301F0E)];
        
        
        return cell;

        
        
    }
    else if (indexPath.section==1)
    {
        
        static NSString *simpleTableIdentifier = @"daimondcell";
        
        DiamondCustomCell *cell = (DiamondCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DiamondCustomCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.groupR1.text = @"A";
        cell.groupR2.text= @"B";
        
        cell.pieceR1.text = [DaiPieceArrOne objectAtIndex:indexPath.row];
        cell.pieceR2.text=[DaiWeightArrOne objectAtIndex:indexPath.row];
        
        cell.weightR1.text = [DaiPieceArrTwo objectAtIndex:indexPath.row];
        cell.weightR1.text=[DaiWeightArrTwo objectAtIndex:indexPath.row];
        
       [cell setBackgroundColor:UIColorFromRGB(0x301F0E)];
        
        
        
        return cell;

        
    }
    else
    {
        static NSString *simpleTableIdentifier = @"gemstonecell";
        
        GemstoneCustomCell *cell = (GemstoneCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GemstoneCustomCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.emeraldPiece.text = [gemsPieces1Array objectAtIndex:indexPath.row];
        cell.rubyPieces.text=[gemsWeight1Array objectAtIndex:indexPath.row];
        
//        cell.emeraldWeight.text = [gemsPiecesArray objectAtIndex:indexPath.row];
//        cell.rubyWeight.text=@"20g";
        [cell setBackgroundColor:UIColorFromRGB(0x301F0E)];
        
        return cell;

    }
    
  
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (collectionView == cartItemsCollection) {
        
        selectedIndexVal=indexPath.row;
                
    }
    else if (collectionView== similaarProductCV)
    {
        
    }
    else
    {
        
    }
       
    
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == similaarProductCV)
    {
         return 50.0;
    }
    else if(collectionView == collectionviewimgs)
    {
        return 50.0;
    }
    else
    {
        return 20.0;
    }
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 23;
}

- (IBAction)onTapMatchingProductPrevious:(id)sender {
    
    [self snapToCellAtIndex:1 withAnimation:YES];
}

- (IBAction)onTapMatchingProductNext:(id)sender {
    
    [self snapToCellAtIndex:0 withAnimation:YES];
   
    
}

- (IBAction)onTapAddCart_btn:(id)sender {
    
   
    
    if (![app.cartListCount containsObject:self.mainImageArray])
    {
        
         [self.cartImageArray addObject:self.mainImageArray];
        [app.cartListCount addObject:self.mainImageArray];
        
        [cartItemsCollection reloadData];
        
         [self hideNoCartLabel];
        NSLog(@"%lu",(unsigned long)self.cartImageArray.count);
        
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Already selected!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
}



- (IBAction)onTapCartNotification_btn:(id)sender {
    
    [self onTapCartView];
    
}

- (IBAction)onTapOpenCart:(id)sender {
    
    [self onTapCartView];
    
}

-(void)onTapCartView
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myCartvc = (MyCartVC *)[storyboard instantiateViewControllerWithIdentifier:@"mycart"];
    
    //myCartvc=[[self storyboard]instantiateViewControllerWithIdentifier:@"mycart"];
    
    
    myCartvc.myCartImageArray=self.cartImageArray;
    
    NSLog(@"%lu",(unsigned long)myCartvc.myCartImageArray.count);
    
    [self.navigationController pushViewController:myCartvc animated:YES];
}

-(void)wishListBadgeCheck
{
  
    
    if([app.wishListCount count]>0)
    {
        wishList_btn.badgeValue=[NSString stringWithFormat:@"%lu", (unsigned long)app.wishListCount.count];
    }
    
}

-(void)cartListBadgeValCheck
{
    if([app.cartListCount count]>0)
    {
        wishList_btn.badgeValue=[NSString stringWithFormat:@"%lu", (unsigned long)app.wishListCount.count];
    }
}

- (IBAction)onTapAddWishList_btn:(id)sender {
    
    if (![app.wishListCount containsObject:self.mainImageArray])
    {
        
        [self.wishListImageArray addObject:self.mainImageArray];
        
        [app.wishListCount addObject:self.wishListImageArray];
        
        [self wishListBadgeCheck];
        
       
        //NSLog(@"%lu",(unsigned long)counts);
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Already selected!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

    
    
}

- (IBAction)onTapWishListNoti_btn:(id)sender {
    
    [self onTapWishListView];
    
}

-(void)onTapWishListView
{
    myWishvc=[[self storyboard]instantiateViewControllerWithIdentifier:@"wishlistvc"];
    myWishvc.wishListvcArray=self.wishListImageArray;
    [self.navigationController pushViewController:myWishvc animated:YES];
}


- (IBAction)onTapWishListFromMatching:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"redHeart.png"];
    [sender setImage:image forState:UIControlStateNormal];
    
    
    
}




- (void) snapToCellAtIndex:(NSInteger)index withAnimation:(BOOL) animated
{
    
  
    NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
  
    [collectionviewimgs scrollToItemAtIndexPath:IndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
    
}
- (IBAction)onTapCloseButton:(id)sender {
    
    //[arrayforimgs removeObjectAtIndex:selectedIndexVal];
    //[clo removeFromSuperview];
    
    
    [self.cartImageArray removeObjectAtIndex:selectedIndexVal];

    [cartItemsCollection reloadData];
    
    [self hideNoCartLabel];
    
}

- (IBAction)onTapSmilarNext_Btn:(id)sender {
    
    
     [self onTapBackAndNextButton:4 withAnimation:YES];
}

- (IBAction)onTapSimilarPrevious_btn:(id)sender {
    
    [self onTapBackAndNextButton:4 withAnimation:YES];
}

- (IBAction)onTapLeftMenu_btn:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}






- (void) onTapBackAndNextButton:(NSInteger)index withAnimation:(BOOL) animated
{
   NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    [similaarProductCV scrollToItemAtIndexPath:IndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
    
}

@end
