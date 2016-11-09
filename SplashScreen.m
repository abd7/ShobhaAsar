//
//  SplashScreen.m
//  Shobha Asasr
//
//  Created by Ascra on 11/8/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "SplashScreen.h"
#import "Constant.h"
#import "AppDelegate.h"

@interface SplashScreen ()<UIApplicationDelegate>

@end

@implementation SplashScreen
@synthesize urlSessionConfig,urlSession,mutableReq,urlSessionConfig1,urlSession1,mutableReq1,urlSessionConfig2,urlSession2,mutableReq2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    splashApp=[[UIApplication sharedApplication]delegate];
    
    
    [self getCollectionData];
    [self getAllProducts];
    [self getAllCategoryData];
    [self dismissViewControllerAnimated:NO completion:NO];
    // Do any additional setup after loading the view.
}
-(void)getAllProducts
{
    urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig];
    
    
    
    mutableReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[BaseUrl stringByAppendingString:get_products]]];
    
    self.urlSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    _collectionDataTask=[self.urlSession dataTaskWithRequest:self.mutableReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                         {
                             NSMutableArray *getallProductArr=[[NSMutableArray alloc]init];
                             
                             getallProductArr  =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                             
                             NSLog(@"--->%@",getallProductArr);
                             
                             [[NSUserDefaults standardUserDefaults] setObject:getallProductArr forKey:@"getproducts"];
                             
                             //[[NSUserDefaults standardUserDefaults] synchronize];
                             
                             
                         }];
    
    [self.collectionDataTask resume];
}

-(void)getCollectionData
{
    urlSessionConfig1 = [NSURLSessionConfiguration defaultSessionConfiguration];
    urlSession1 = [NSURLSession sessionWithConfiguration:urlSessionConfig1];
    
    
    
    mutableReq1 = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[BaseUrl stringByAppendingString:get_collections]]];
    
    self.urlSession1=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    _collectionDataTask1=[self.urlSession1 dataTaskWithRequest:self.mutableReq1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                         {
                             NSMutableArray *collectionArr=[[NSMutableArray alloc]init];
                             
                             collectionArr  =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                             
                             NSLog(@"--->%@",collectionArr);
                             
                             [[NSUserDefaults standardUserDefaults] setObject:collectionArr forKey:@"collection"];
                             
                             //[[NSUserDefaults standardUserDefaults] synchronize];
                             
                             
                         }];
    
    [self.collectionDataTask1 resume];
    
    
    }
-(void)getAllCategoryData
{
    urlSessionConfig2 = [NSURLSessionConfiguration defaultSessionConfiguration];
    urlSession2 = [NSURLSession sessionWithConfiguration:urlSessionConfig2];
    
    
    
    mutableReq2 = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[BaseUrl stringByAppendingString:get_category]]];
    
    self.urlSession2=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    _collectionDataTask2=[self.urlSession2 dataTaskWithRequest:self.mutableReq2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                          {
                              NSMutableArray *categoryArr=[[NSMutableArray alloc]init];
                              
                              categoryArr  =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                              
                              
                              
                              [[NSUserDefaults standardUserDefaults] setObject:categoryArr forKey:@"category"];
                              
                             NSLog(@"--->%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"category"]);
                              
                              //[[NSUserDefaults standardUserDefaults] synchronize];
                              
                              
                          }];
    
    [self.collectionDataTask2 resume];
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
