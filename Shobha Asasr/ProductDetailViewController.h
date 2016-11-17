//
//  ProductDetailViewController.h
//  Shobha Asasr
//
//  Created by AscratechMacmini on 14/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartCollectionCell.h"


@class AppDelegate;

@interface ProductDetailViewController : UIViewController<UINavigationBarDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITabBarDelegate,UITableViewDelegate,UIApplicationDelegate, UIGestureRecognizerDelegate>
{
   AppDelegate *app;
    IBOutlet UIView *cellfirstview;
   
   
 
    
    IBOutlet UICollectionView *collectionviewimgs;
    IBOutlet UITableView *ornamentLstTable;
    IBOutlet UILabel *metalName;
    NSMutableArray *nameArray,*purityArray,*weightArray,*arrayforimgs,*DaiPieceArrOne,*DaiPieceArrTwo,*DaiWeightArrOne,*DaiWeightArrTwo,*gemsPieces1Array,*gemsWeight1Array,*gemsPieces2Array,*gemsWeight2Array;
    
    
    IBOutlet UICollectionView *cartItemsCollection;
    IBOutlet UILabel *collectionNameLabel;
    
    IBOutlet UILabel *styleNo;
    IBOutlet UICollectionView *similaarProductCV;
    NSInteger count;
   
    IBOutlet UIImageView *proDetails_imageView;
    IBOutlet UILabel *styleNoLabel;
    IBOutlet UILabel *noCartLabel;
    IBOutlet UIButton *wishList_btn;
    IBOutlet UIButton *cart_btn;
}

@property NSInteger indexVal;
@property NSMutableArray *mainImageArray,*cartImageArray,*wishListImageArray;

@property NSData *imagedata;

@property NSString *productTypeName,*productStyleNo;
@property (strong, nonatomic) IBOutlet UIScrollView *product_Scroll;
@property NSMutableArray *sectionTitlesArray;
@property (strong, nonatomic) IBOutlet UITableView *sizeListTableView;

@property (strong, nonatomic) IBOutlet UIView *sizeListView;
@property (strong, nonatomic) IBOutlet UIButton *dropDown;
@property (strong, nonatomic) IBOutlet UILabel *sizeListTextView;

- (IBAction)onTapCloseButton:(id)sender;
- (IBAction)onTapSmilarNext_Btn:(id)sender;
- (IBAction)onTapSimilarPrevious_btn:(id)sender;
- (IBAction)onTapLeftMenu_btn:(id)sender;
- (IBAction)onTapOpenCart:(id)sender;
- (IBAction)onTapMatchingProductPrevious:(id)sender;

- (IBAction)onTapMatchingProductNext:(id)sender;
- (IBAction)onTapAddCart_btn:(id)sender;
- (IBAction)onTapAddWishList_btn:(id)sender;


- (IBAction)onTapCartNotification_btn:(id)sender;
- (IBAction)onTapWishListNoti_btn:(id)sender;
- (IBAction)dropDownButton:(id)sender;


@end
