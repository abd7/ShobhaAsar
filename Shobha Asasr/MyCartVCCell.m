//
//  MyCartVCCell.m
//  Shobha Asasr
//
//  Created by Ascra on 10/26/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "MyCartVCCell.h"

@implementation MyCartVCCell

- (IBAction)onTapCartButton:(id)sender {
    UIImage *image = [UIImage imageNamed:@"redHeart.png"];
    [sender setImage:image forState:UIControlStateNormal];
    
}
@end
