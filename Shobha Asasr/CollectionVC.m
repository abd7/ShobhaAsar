//
//  CollectionVC.m
//  Shobha Asasr
//
//  Created by Ascra on 10/24/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "CollectionVC.h"
#import "Constant.h"



@interface CollectionVC ()
{

    NSString *collTitleName;
    NSString *urlName;
    CategoryVC *categoryvc;
    ViewController *listingPage;
    
}


@end

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]
@implementation CollectionVC
@synthesize necklace_btn,pendant_btn,bangles_btn,ring_btn,earrings_btn,bracelets_btn,allProductsDic;
@synthesize urlSession,urlSessionConfig,mutableReq,imageArr,priceArr,style_id,product_idArray;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self tabButton];
    tab_Btn.hidden=YES;
    tab_Btn2.hidden=NO;
 
    necklace_btn.layer.borderWidth=1.0f;
    necklace_btn.layer.borderColor=UIColorFromRGB(0xE8D0A1).CGColor;
    
    pendant_btn.layer.borderWidth=1.0f;
    pendant_btn.layer.borderColor=UIColorFromRGB(0xE8D0A1).CGColor;
    
    urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig];
    
  
    allProductsDic=[[NSMutableDictionary alloc]init];
  
    
    imageArr=[[NSMutableArray alloc]init];
    priceArr=[[NSMutableArray alloc]init];
    style_id=[[NSMutableArray alloc]init];
    product_idArray=[[NSMutableArray alloc]init];
    _stockArr=[[NSMutableArray alloc]init];
    
    [necklace_btn addTarget:self action:@selector(onTapCollection_btns:) forControlEvents:UIControlEventTouchUpInside];
    [ring_btn addTarget:self action:@selector(onTapCollection_btns:) forControlEvents:UIControlEventTouchUpInside];
    [earrings_btn addTarget:self action:@selector(onTapCollection_btns:) forControlEvents:UIControlEventTouchUpInside];
    [bracelets_btn addTarget:self action:@selector(onTapCollection_btns:) forControlEvents:UIControlEventTouchUpInside];
    [bangles_btn addTarget:self action:@selector(onTapCollection_btns:) forControlEvents:UIControlEventTouchUpInside];
    [pendant_btn addTarget:self action:@selector(onTapCollection_btns:) forControlEvents:UIControlEventTouchUpInside];
    

    
}


-(void)tabButton
{
    tab_Btn=[[UIButton alloc]initWithFrame:CGRectMake(collection_btn.frame.origin.x,0,collection_btn.frame.size.width, 3)];
    
    tab_Btn.backgroundColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0];
    [underLineView addSubview:tab_Btn];
    
    tab_Btn2=[[UIButton alloc]initWithFrame:CGRectMake(category_btn.frame.origin.x,0,category_btn.frame.size.width, 3)];
    tab_Btn2.backgroundColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0];
    [underLineView addSubview:tab_Btn2];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onTapCollection_btn:(id)sender {
    
    tab_Btn.hidden=NO;
    tab_Btn2.hidden=YES;
    
    categoryvc=[[self storyboard]instantiateViewControllerWithIdentifier:@"categoryvc"];
    [self.navigationController pushViewController:categoryvc animated:YES];
    
   
}

- (IBAction)onTapCategory_btn:(id)sender {
    
    tab_Btn.hidden=YES;
    tab_Btn2.hidden=NO;
    
    
    
}




- (void)onTapCollection_btns:(UIButton*)sender
{
    [imageArr removeAllObjects];
    [priceArr removeAllObjects];
    [style_id removeAllObjects];
    [product_idArray removeAllObjects];
    

    
     NSLog(@"---> %ld", (long int)[sender tag]);
    
    if (sender.tag==10) {
        
        listingPage=[[self storyboard]instantiateViewControllerWithIdentifier:@"ViewController"];
        urlName=[BaseUrl stringByAppendingString:get_products];
        listingPage.collectionName=@"NECKLACE";
        [self getDataFromServer];
         [self.navigationController pushViewController:listingPage animated:YES];
        
    }
    else if (sender.tag==11)
    {
        listingPage=[[self storyboard]instantiateViewControllerWithIdentifier:@"ViewController"];
        urlName=[BaseUrl stringByAppendingString:get_products];
        listingPage.collectionName=@"RINGS";
        [self getDataFromServer];
         [self.navigationController pushViewController:listingPage animated:YES];
        
    }
    else if (sender.tag==12)
    {
        listingPage=[[self storyboard]instantiateViewControllerWithIdentifier:@"ViewController"];
        urlName=[BaseUrl stringByAppendingString:get_products];
        listingPage.collectionName=@"EARRINGS";
        [self getDataFromServer];
         [self.navigationController pushViewController:listingPage animated:YES];
    }
    else if (sender.tag==13)
    {
        listingPage=[[self storyboard]instantiateViewControllerWithIdentifier:@"ViewController"];
        urlName=[BaseUrl stringByAppendingString:get_products];
        listingPage.collectionName=@"BRACELETS";
        [self getDataFromServer];
         [self.navigationController pushViewController:listingPage animated:YES];
        
    }
    else if (sender.tag==14)
    {
        listingPage=[[self storyboard]instantiateViewControllerWithIdentifier:@"ViewController"];
        urlName=[BaseUrl stringByAppendingString:get_products];
        listingPage.collectionName=@"BENGLES";
        [self getDataFromServer];
         [self.navigationController pushViewController:listingPage animated:YES];
        
    }
    else
    {
        listingPage=[[self storyboard]instantiateViewControllerWithIdentifier:@"ViewController"];
        urlName=[BaseUrl stringByAppendingString:get_products];
        listingPage.collectionName=@"PENDANT";
        [self getDataFromServer];
         [self.navigationController pushViewController:listingPage animated:YES];
        
    }
    
   
    
}
-(void)getDataFromServer
{
    
    //[self show_Loader];
    
    NSMutableString *postString;

    _requesteAPI = nil;
    _requesteAPI = [[WebServiceParsing alloc] getDataFromURLStringForPost:postString];
    NSLog(@"-->%@",_requesteAPI);
    _requesteAPI.requestDelegate = self;
    

    
//    urlName=[BaseUrl stringByAppendingString:get_products];
//    
//    mutableReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlName]];
//    
//    self.urlSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    _collectionDataTask=[self.urlSession dataTaskWithRequest:self.mutableReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
//                   {
//                       NSMutableArray *servArray=[[NSMutableArray alloc]init];
//                       
//                     servArray  =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                    
//                       [[NSUserDefaults standardUserDefaults] setObject:servArray forKey:@"productDetails"];
//                     
//                       [[NSUserDefaults standardUserDefaults] synchronize];
//                       
//                               for (NSDictionary *appDic in servArray)
//                               {
//                       
//                                   [imageArr addObject:[appDic objectForKey:@"image1"]];
//                                   listingPage.arrayForimgs=imageArr;
//                       
//                                   NSLog(@"---- >%lu",(unsigned long)listingPage.arrayForimgs.count);
//                       
//                               }
//                               for (NSDictionary *appDic in servArray)
//                               {
//                                   [priceArr addObject:[appDic objectForKey:@"price"]];
//                                   listingPage.priceArray=priceArr;
//                                   
//                               }
//                               
//                               for (NSDictionary *appDic in servArray)
//                               {
//                                   
//                                  [style_id addObject:[appDic objectForKey:@"style_id"]];
//                                   listingPage.styleArray=style_id;
//                                   
//                               }
//                       
//                               for (NSDictionary *appDic in servArray)
//                               {
//                           
//                                   [product_idArray addObject:[appDic objectForKey:@"id"]];
//                                 listingPage.productID=product_idArray;
//                                }
//                       
//                       for (NSDictionary *appDic in servArray)
//                       {
//                           
//                           [product_idArray addObject:[appDic objectForKey:@"id"]];
//                           listingPage.productID=product_idArray;
//                       }
//                       
//                       for (NSDictionary *appDic in servArray)
//                       {
//                           
//                           [product_idArray addObject:[appDic objectForKey:@"id"]];
//                           listingPage.productID=product_idArray;
//                       }
//                       for (NSDictionary *appDic  in  servArray) {
//                           [_stockArr addObject:[appDic objectForKey:@"in_stock_status"]];
//                           listingPage.stockArray=_stockArr;
//                       }
//                       
//                           [listingPage.collectionviewimgs reloadData];
//                       
//                   }];
//    
//    [self.collectionDataTask resume];
  
}



-(void)switchToListingPage

{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *myVC = (ViewController *)[storyboard instantiateViewControllerWithIdentifier:@"listingpage"];
    listingPage.collectionName=[NSString stringWithFormat:@"%@",collTitleName];
    [self.navigationController pushViewController:myVC animated:YES];
}
@end
