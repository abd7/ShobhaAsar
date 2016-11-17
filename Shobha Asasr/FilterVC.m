//
//  FilterVC.m
//  Shobha Asasr
//
//  Created by Ascra on 11/3/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "FilterVC.h"
#import "ItemFIlterCell.h"
#import "ShobhaAsarDataBase.h"


@interface FilterVC ()
{
    NSMutableArray *tableTitles;
    ItemFIlterCell *cell;
}

@end
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation FilterVC
@synthesize collection_btn,category_btn,instock_btn,size_btn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    tableTitles=[[NSMutableArray alloc]initWithObjects:@"Collections",@"Sub-Category",@"Stock Status",@"Size", nil];
 
    _filterTable.dataSource=self;
    _filterTable.delegate=self;
    
    _filterTable.separatorColor = [UIColor clearColor];
  
    
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
    
    
    
    
    
    
    [collection_btn addTarget:self action:@selector(onTapCollection_btn:) forControlEvents:UIControlEventTouchUpInside];
    [category_btn addTarget:self action:@selector(onTapCollection_btn:) forControlEvents:UIControlEventTouchUpInside];
    [instock_btn addTarget:self action:@selector(onTapCollection_btn:) forControlEvents:UIControlEventTouchUpInside];
    [size_btn addTarget:self action:@selector(onTapCollection_btn:) forControlEvents:UIControlEventTouchUpInside];
}



-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum{
    
    
    if (sender == self.filterSlider){
        NSLog(@"Standard slider updated. Min Value: %.0f Max Value: %.0f", selectedMinimum, selectedMaximum);
    }
    else if (sender == self.filterPrice) {
        NSLog(@"Currency slider updated. Min Value: %.0f Max Value: %.0f", selectedMinimum, selectedMaximum);
    }
    
}



-(void)onTapCollection_btn:(UIButton *)sender
{
    ShobhaAsarDataBase *database=[[ShobhaAsarDataBase alloc]init];
    [database getFilterData];
    
    NSArray *filterArray=[[NSUserDefaults standardUserDefaults]valueForKey:@"filterData"];
    
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Price >=  %@ AND Price <=  %@",self.filterSlider.selectedMinimum,self.filterSlider.selectedMaximum];
    
    for (int i=0; i<filterArray.count; i++)
    {
        if ([[filterArray objectAtIndex:i]valueForKey:@"price"] >=0) {
            
        }
        
        
         NSArray *filter = [[[filterArray objectAtIndex:i]valueForKey:@"price"] filteredArrayUsingPredicate:predicate];
        NSLog(@"--->pricefilter Data %@",filter);
        }
        
    
    
    //NSArray *filter = [filterArray filteredArrayUsingPredicate:predicate];
    
    
    if (sender.tag==1) {
        
       
        
    }
    else if (sender.tag==2)
    {
       
        
        
    }else if (sender.tag==3)
    {
        
        
    }else if (sender.tag==4)
    {
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
        return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
       return 4;
  
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
        cell = [tableView dequeueReusableCellWithIdentifier:@"filtercell" forIndexPath:indexPath];
        
        cell.itemLabel.text=[NSString stringWithFormat:@"    %@",[tableTitles objectAtIndex:indexPath.row]];
    cell.checkBox_btn.layer.borderWidth=1.0f;
    cell.checkBox_btn.layer.borderColor=UIColorFromRGB(0xE8D0A1).CGColor;
    
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

@end
