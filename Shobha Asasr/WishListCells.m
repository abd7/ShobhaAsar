//
//  WishListCells.m
//  Shobha Asasr
//
//  Created by Ascra on 10/26/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "WishListCells.h"

@implementation WishListCells

- (IBAction)onTapWishList_cartBtn:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"redHeart.png"];
    [sender setImage:image forState:UIControlStateNormal];
}
@end
