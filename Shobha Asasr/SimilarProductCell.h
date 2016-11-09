//
//  SimilarProductCell.h
//  Shobha Asasr
//
//  Created by Ascra on 10/22/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimilarProductCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *similarItemImage;
@property (strong, nonatomic) IBOutlet UIView *similarItemView;
- (IBAction)onTapWishlist:(id)sender;

@end
