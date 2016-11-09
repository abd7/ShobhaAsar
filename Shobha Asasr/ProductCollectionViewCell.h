//
//  ProductCollectionViewCell.h
//  Shobha Asasr
//
//  Created by AscratechMacmini on 14/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgview;
@property (strong, nonatomic) IBOutlet UILabel *ratelbl;


@property (strong, nonatomic) IBOutlet UIView *cellview;
@property (strong, nonatomic) IBOutlet UIButton *wishButton;
@property (strong, nonatomic) IBOutlet UIImageView *wishImage;
- (IBAction)onTapMatchingWishList_btn:(id)sender;

@end
