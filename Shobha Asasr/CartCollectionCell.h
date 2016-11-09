//
//  CartCollectionCell.h
//  Shobha Asasr
//
//  Created by Ascra on 10/22/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cartImageView;
@property (strong, nonatomic) IBOutlet UIButton *remove_btn;
- (IBAction)onTapClose_btn:(id)sender;

@end
