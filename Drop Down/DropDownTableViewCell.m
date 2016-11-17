//
//  DropDownTableViewCell.m
//  V2CompomentsInternal
//
//  Created by apoorva on 30/06/16.
//  Copyright © 2016 V2Solutions. All rights reserved.
//

#import "DropDownTableViewCell.h"
#import "UIFont+V2Font.h"
#import "UIColor+V2Color.h"

@implementation DropDownTableViewCell



- (void)awakeFromNib {
    // Initialization code
    self.textLabel.font = [UIFont V2LabeledTextFieldFont];
    self.textLabel.textColor = [UIColor V2LabeledTextColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"DropDownTableViewCell" owner:self options:nil];
        [self addSubview:self.view];
    }
    return self;
}

@end
