//
//  WishListCells.h
//  Shobha Asasr
//
//  Created by Ascra on 10/26/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListCells : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIView *wishlistView;
@property (strong, nonatomic) IBOutlet UIImageView *wishlistImageView;
@property (strong, nonatomic) IBOutlet UIButton *wishList_cartBtn;
@property (strong, nonatomic) IBOutlet UILabel *wishList_priceTag;
@property (strong, nonatomic) IBOutlet UILabel *wishList_styleNo;

- (IBAction)onTapWishList_cartBtn:(id)sender;
@end
