//
//  WishListVC.h
//  Shobha Asasr
//
//  Created by Ascra on 10/26/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;

@interface WishListVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIApplicationDelegate>
{
    AppDelegate *appDel;
    
    IBOutlet UIButton *wishList_btn;
    
    IBOutlet UIButton *cart_btn;
}

@property NSMutableArray *wishListvcArray;


@property (strong, nonatomic) IBOutlet UICollectionView *wishlistCV;
- (IBAction)onTapLeftMenu_btn:(id)sender;
- (IBAction)onTapRemoveWishList:(id)sender;

@end
