//
//  V2DropDown.h
//  V2CompomentsInternal
//
//  Created by apoorva on 29/06/16.
//  Copyright © 2016 V2Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+V2Color.h"
#import "UIFont+V2Font.h"

typedef NS_ENUM(NSInteger, DropDownAnimationStyle) {
    DropDownDefault,
    DropDownBouncing
};

@interface V2DropDown : UIControl <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@property (nonatomic, assign) DropDownAnimationStyle style;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *arrowButton;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (assign,nonatomic) NSString *placeholder;
@property (strong,nonatomic) NSMutableArray *optionsArray;

@end
