//
//  Indicator.m
//  WatchMovement
//
//  Created by promatics on 5/15/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "Indicator.h"

@implementation Indicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
 
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        //[_indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [_indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [_indicatorView setCenter: self.center];
        //_indicatorView.color = UIColorFromRGB(title_color_hexcode);//[UIColor whiteColor];
        
        _indicatorView.layer.cornerRadius = 5.0;
        _indicatorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];//UIColorFromRGB(text_color_hexcode);
       
        [_indicatorView startAnimating];
        
        [self addSubview:_indicatorView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-10, 50, 80, 20)];
        label.text = @"Loading...";
        [label setFont:[UIFont fontWithName:@"OpenSans-Regular" size:11]];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor]; //UIColorFromRGB(title_color_hexcode);//
       // [label sizeToFit];
        [_indicatorView addSubview:label];
    }
    return self;
}


@end
