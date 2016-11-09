//
//  SimilarProductCell.m
//  Shobha Asasr
//
//  Created by Ascra on 10/22/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "SimilarProductCell.h"

@implementation SimilarProductCell

- (IBAction)onTapWishlist:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"redHeart.png"];
    [sender setImage:image forState:UIControlStateNormal];
}
@end
