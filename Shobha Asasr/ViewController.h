//
//  ViewController.h
//  Shobha Asasr
//
//  Created by AscratechMacmini on 13/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCollectionViewCell.h"
#import "ProductDetailViewController.h"
@class AppDelegate;

@interface ViewController : UIViewController<UINavigationBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    AppDelegate *app;
    __weak IBOutlet UIImageView *blurimg;
    UIView *firststview;
    
    IBOutlet UIButton *filter_btn;
    
    IBOutlet UIButton *listingWishListButton;
    
    IBOutlet UIButton *listingCartBtn;
    
}




@property (strong, nonatomic) IBOutlet UICollectionView *collectionviewimgs;



@property NSMutableArray *arrayForimgs,*priceArray,*styleArray,*productID,*paramArray,*stockArray;

@property NSString *collectionName;


@property (strong, nonatomic) IBOutlet UIView *topMenuView;
@property (strong, nonatomic) IBOutlet UIButton *category_btn;
@property (strong, nonatomic) IBOutlet UIButton *collection_btn;
@property (strong, nonatomic) IBOutlet UILabel *collectionTitleLabel;


- (IBAction)onTapWishList_btn:(id)sender;
- (IBAction)onTapCart_btn:(id)sender;


- (IBAction)onTapCollection_btn:(id)sender;
- (IBAction)onTapCategory_btn:(id)sender;

- (IBAction)onTapLeftMenu_btn:(id)sender;
- (IBAction)onTapFilter_btn:(id)sender;




@end

