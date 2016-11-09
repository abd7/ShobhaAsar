//
//  ProductCollectionViewCell.m
//  Shobha Asasr
//
//  Created by AscratechMacmini on 14/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "ProductCollectionViewCell.h"


@implementation ProductCollectionViewCell



- (IBAction)onTapMatchingWishList_btn:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"redHeart.png"];
    [sender setImage:image forState:UIControlStateNormal];
}
@end
