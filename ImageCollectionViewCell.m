//
//  ImageCollectionViewCell.m
//  Shobha Asasr
//
//  Created by AscratechMacmini on 13/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell
@synthesize cartbtnoutlet,wishListButton;



- (IBAction)wishlstbtn:(id)sender
{
    
    
    UIImage *image = [UIImage imageNamed:@"redHeart.png"];
    [sender setImage:image forState:UIControlStateNormal];
    
}
- (IBAction)cartbtn:(id)sender
{
    //[cartbtnoutlet setBackgroundColor:[UIColor lightTextColor]];
    
    UIImage *image = [UIImage imageNamed:@"Cart Btn.png"];
    [sender setImage:image forState:UIControlStateNormal];
    
}



@end
