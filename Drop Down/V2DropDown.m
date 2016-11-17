 //
//  V2DropDown.m
//  V2CompomentsInternal
//
//  Created by apoorva on 29/06/16.
//  Copyright © 2016 V2Solutions. All rights reserved.
//

#import "V2DropDown.h"
#import "DropDownTableViewCell.h"

@implementation V2DropDown

- (void)commonInit
{
    if (self) {
        
        [[NSBundle mainBundle] loadNibNamed:@"V2DropDown" owner:self options:nil];
        self.table.delegate = self;
        self.table.dataSource = self;
        [self addSubview:self.view];
        self.titleLabel.textColor = [UIColor V2LabeledTextFieldTextColor];
        [self.table setHidden:YES];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
        [self updateSelf];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self updateSelf];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
        [self updateSelf];
    }
    return self;
}


- (void)updateSelf {

    CGRect separatorFrame = CGRectMake(self.separatorView.frame.origin.x, self.separatorView.frame.origin.y,self.separatorView.frame.size.width,0.5);
    self.separatorView.frame = separatorFrame;
    self.table.layer.borderColor = [UIColor V2TextFieldGrayBottomColor].CGColor;;
    self.table.layer.borderWidth = 0.5;
    self.titleLabel.font = [UIFont V2LabeledTextFieldFont];
    self.titleLabel.textColor = [UIColor V2LabeledTextFieldTextColor];
    [self.arrowButton addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touch {
    self.selected = !self.selected;
    //self.userInteractionEnabled = false;
    self.selected ? [self showTable] : [self hideTable];
}


-(BOOL)resignFirstResponder {
    if (self.selected) {
        [self hideTable];
    }
    return true;
}

- (void)showTable {
    [self.table setHidden:NO];
    self.titleLabel.textColor = [UIColor V2LabeledTextColor];
//    [self.view addSubview:self.table];
    [self.table reloadData];
    [UIView animateWithDuration:0.2
                     animations:^{
        self.arrowButton.transform = CGAffineTransformMakeRotation((180.0 * M_PI)/180.0);
    }];
    
    switch (self.style) {
        case DropDownDefault:
        {
            
            [UIView animateWithDuration:1.5
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0.1
                                options:UIViewAnimationOptionTransitionFlipFromTop
                             animations:^{
                                 self.table.alpha = 1;
                             }
                             completion:^(BOOL finished){
                                 [self.table setHidden:NO];
                                 self.userInteractionEnabled = true;
                             }];
            
            [self.table reloadData];
        }
            break;
            
        case DropDownBouncing:
        {
            self.table.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            
            [UIView animateWithDuration:0.9
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0.1
                                options:UIViewAnimationOptionTransitionCurlUp
                             animations:^{
                                 self.table.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                                 self.table.alpha = 1;
                                 
                             }
                             completion:^(BOOL finished){
                                [self.table setHidden:NO];
                                 self.userInteractionEnabled = true;
                             }];
            
            [self.table reloadData];

        }
            break;
            
        default:
            
            break;
    }
}

- (void)hideTable {
    [self.table setHidden:YES];
    self.titleLabel.textColor = [UIColor V2LabeledTextFieldTextColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.arrowButton.transform = CGAffineTransformMakeRotation(0);
                     }];
    
    switch (self.style) {
        case DropDownDefault:
        {
            
            [UIView animateWithDuration:0.5
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0.1
                                options:UIViewAnimationOptionTransitionFlipFromBottom
                             animations:^{
                                 self.table.alpha = 0;
                                 
                             }
                             completion:^(BOOL finished){
                                 [self.table setHidden:YES];
                                 self.userInteractionEnabled = true;
                                 self.selected = false;
                             }];
            [self.table reloadData];
        }
            break;
            
        case DropDownBouncing:
        {
            [UIView animateWithDuration:0.5
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0.1
                                options:UIViewAnimationOptionTransitionCurlUp
                             animations:^{
                                 self.table.alpha = 0;
                                 
                             }
                             completion:^(BOOL finished){
                                 [self.table setHidden:YES];
                                 self.userInteractionEnabled = true;
                                 self.selected = false;
                             }];
            [self.table reloadData];
        }
            break;
            
        default:
            
            break;
    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.optionsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DropDownTableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil){
        cell = [[DropDownTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    cell.textLabel.text = self.optionsArray[indexPath.row];
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = [NSString stringWithFormat:@"    %@",self.optionsArray[indexPath.row]];
    
    [UIView animateWithDuration:0.6 animations:^{
        self.titleLabel.alpha = 1.0;
    }];
    [self hideTable];
//    [self.table setHidden:YES];
//    [UIView animateWithDuration:0.2
//                     animations:^{
//                         self.arrowButton.transform = CGAffineTransformMakeRotation(0);
//                     }];
    [tableView reloadData];
    
}

@end
