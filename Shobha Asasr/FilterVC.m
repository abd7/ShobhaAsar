//
//  FilterVC.m
//  Shobha Asasr
//
//  Created by Ascra on 11/3/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "FilterVC.h"


@interface FilterVC ()
{
    NSMutableArray *tableTitles;
}

@end

@implementation FilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    tableTitles=[[NSMutableArray alloc]initWithObjects:@"Collections",@"Sub-Category",@"Stock Status",@"Size", nil];
 
    _filterTable.dataSource=self;
    _filterTable.delegate=self;
    self.filterTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.filterTable.frame.size.width, 1)];
    
    NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
    customFormatter.positivePrefix = @"₹";
    
    self.filterSlider.numberFormatterOverride = customFormatter;
    self.filterSlider.delegate = self;
    self.filterSlider.minValue = 0;
    self.filterSlider.maxValue = 150000;
    self.filterSlider.selectedMinimum = 15000;
    self.filterSlider.selectedMaximum = 50000;
    self.filterSlider.handleColor = [UIColor whiteColor];
    self.filterSlider.handleDiameter = 20;
    self.filterSlider.selectedHandleDiameterMultiplier = 2;
    self.filterSlider.tintColorBetweenHandles = [UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0];
   
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"filtercell" forIndexPath:indexPath];
    
    cell.textLabel.text=[NSString stringWithFormat:@"    %@",[tableTitles objectAtIndex:indexPath.row]];
    cell.textLabel.textColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark TTRangeSliderViewDelegate
-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum{
    
    if (sender == self.filterSlider)
    {
        NSLog(@"Slider Min Value: %.0f Max Value: %.0f", selectedMinimum, selectedMaximum);
    }
    
}
@end
