//
//  MyCartVCCell.h
//  Shobha Asasr
//
//  Created by Ascra on 10/26/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCartVCCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *myCart_view;
@property (strong, nonatomic) IBOutlet UIImageView *myCart_imageView;
@property (strong, nonatomic) IBOutlet UIButton *myCart_btn;
@property (strong, nonatomic) IBOutlet UILabel *myCart_priceTag;
@property (strong, nonatomic) IBOutlet UILabel *myCart_styleNo;
- (IBAction)onTapCartButton:(id)sender;


@end
