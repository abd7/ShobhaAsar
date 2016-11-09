//
//  ImageCollectionViewCell.h
//  Shobha Asasr
//
//  Created by AscratechMacmini on 13/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell

@property(strong,nonatomic)IBOutlet UILabel *priceLabel;
@property(strong,nonatomic)IBOutlet UILabel *styleLabel;
@property (strong, nonatomic) IBOutlet UIView *cellview;

@property (strong, nonatomic) IBOutlet UIButton *cartbtnoutlet;
@property (strong, nonatomic) IBOutlet UIButton *wishListButton;
@property (strong, nonatomic) IBOutlet UIImageView *jewelimg;
@property (strong, nonatomic) IBOutlet UIButton *inStockTag;




- (IBAction)wishlstbtn:(id)sender;
- (IBAction)cartbtn:(id)sender;




@end
