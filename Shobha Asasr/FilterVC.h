//
//  FilterVC.h
//  Shobha Asasr
//
//  Created by Ascra on 11/3/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRangeSlider.h"

@interface FilterVC : UIViewController<TTRangeSliderDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet TTRangeSlider *filterSlider;
@property (strong, nonatomic) IBOutlet UITableView *filterTable;
@property (strong, nonatomic) IBOutlet UIScrollView *filterScroll;

@end
