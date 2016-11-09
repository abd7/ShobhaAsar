//
//  CategoryVC.m
//  Shobha Asasr
//
//  Created by Ascra on 11/5/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "CategoryVC.h"
#import "CollectionVC.h"

@interface CategoryVC ()
{
    CollectionVC *collectionvc;
}

@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tabButton];
    
    
    tab_btn.hidden=NO;
    tab_btn2.hidden=YES;
    // Do any additional setup after loading the view.
}


-(void)tabButton
{
    tab_btn=[[UIButton alloc]initWithFrame:CGRectMake(collection_btn.frame.origin.x,0,collection_btn.frame.size.width, 3)];
    
    tab_btn.backgroundColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0];
    [underLineView addSubview:tab_btn];
    
    tab_btn2=[[UIButton alloc]initWithFrame:CGRectMake(category_btn.frame.origin.x,0,category_btn.frame.size.width, 3)];
    tab_btn2.backgroundColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0];
    [underLineView addSubview:tab_btn2];
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
-(BOOL)prefersStatusBarHidden
{
    return YES;
}


- (IBAction)onTapLeftMenu_btn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onTapCollection_btn:(id)sender {
    
    tab_btn.hidden=NO;
    tab_btn2.hidden=YES;
    
   
}

- (IBAction)onTapCategory_btn:(id)sender {
    
    tab_btn.hidden=YES;
    tab_btn2.hidden=NO;
    
    collectionvc=[[self storyboard]instantiateViewControllerWithIdentifier:@"collectionvc"];
    [self.navigationController pushViewController:collectionvc animated:YES];
    
}
@end
