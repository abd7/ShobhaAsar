//
//  CollectionVC.m
//  Shobha Asasr
//
//  Created by Ascra on 10/24/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "CollectionVC.h"
#import "Constant.h"
#import "WebServiceParsing.h"
#import "Reachability.h"
#import "ShobhaAsarDataBase.h"
#import <sqlite3.h>
#import "UIColor+ColorCategory.h"
#import "AppDelegate.h"
#import "Indicator.h"



@interface CollectionVC ()
{

    NSString *collTitleName;
    ViewController *listingPage;
    UIScrollView *scrollview;
    
    
    
    NSMutableArray *collectFullDataArr;
    NSMutableArray *collectHalfData;
    
    NSMutableArray *categoryFullDataArr;
    NSMutableArray *categoryHalfData;
    
    NSMutableArray *collectData;
    NSMutableArray *categoryData;
    Indicator *indicatorrr;
  
    
}


@end

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]
@implementation CollectionVC

@synthesize imageArr,priceArr,style_id,product_idArray;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self tabButton];
    tab_Btn.hidden=YES;
    tab_Btn2.hidden=NO;
    
    indicatorrr=[[Indicator alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [indicatorrr setBackgroundColor:UIColorFromRGB(0x1E1409)];
    
    
    [indicatorrr setHidden:YES];
    //[indicator setHidden:YES];
    
    [self callWebService];
    [self getCollectionData];
    [self getcategoryData];
    
   
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    
    [self.view addSubview:scrollview];
 
  
    
    imageArr=[[NSMutableArray alloc]init];
    priceArr=[[NSMutableArray alloc]init];
    style_id=[[NSMutableArray alloc]init];
    product_idArray=[[NSMutableArray alloc]init];
    _stockArr=[[NSMutableArray alloc]init];
    
    
    collectFullDataArr=[[NSMutableArray alloc]init];
    collectHalfData=[[NSMutableArray alloc]init];
    categoryFullDataArr=[[NSMutableArray alloc]init];
    categoryHalfData=[[NSMutableArray alloc]init];
    
    app=[[UIApplication sharedApplication]delegate];
    [self getCategoryDefaultData];
    

    
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


-(void)getCollectionData
{
    
    [indicatorrr setHidden:NO];
    [self.view addSubview:indicatorrr];
    
    NSURLSession * urlSession;
    NSURLSessionConfiguration * urlSessionConfig;
    NSURLSessionDataTask * collectionDataTask;
    NSMutableURLRequest * mutableReq;
    
    urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig];
    
    
    NSString* urlName=[BaseUrl stringByAppendingString:get_collections];
    
    mutableReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlName]];
    
    urlSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    collectionDataTask=[urlSession dataTaskWithRequest:mutableReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                        {
                            NSMutableArray *servArray=[[NSMutableArray alloc]init];
                            
                            
                            NSMutableDictionary * dataDictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            
                            servArray=[dataDictionary objectForKey:@"COLLECTION"];
                            
                            // NSMutableArray *collectionMASTERArray=[servArray objectAtIndex:0];
                            
                            [self addCollectionDetails:servArray];
                            
                        }];
    
    [collectionDataTask resume];
     [indicatorrr removeFromSuperview];
    [indicatorrr setHidden:YES];
}

-(void)getcategoryData
{
    [indicatorrr setHidden:NO];
    [self.view addSubview:indicatorrr];
    
    NSURLSession * urlSession;
    NSURLSessionConfiguration * urlSessionConfig;
    NSURLSessionDataTask * collectionDataTask;
    NSMutableURLRequest * mutableReq;
    
    urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig];
    
    
    NSString* urlName=[BaseUrl stringByAppendingString:get_category];
    
    mutableReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlName]];
    
    urlSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    collectionDataTask=[urlSession dataTaskWithRequest:mutableReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                        {
                            NSMutableArray *cartArray=[[NSMutableArray alloc]init];
                            
                            
                            NSMutableDictionary * dataDictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            
                            cartArray=[dataDictionary objectForKey:@"CATEGORY_MASTER"];
                            [self addCategoryDetails:cartArray];
                            
                            
                            
                        }];
    
    [collectionDataTask resume];
    
}

-(void)callWebService
{
    BOOL interNetCheck=[WebServiceParsing InternetCheck];
    
    
    if (interNetCheck==YES)
    {
        
        
        NSMutableString *postString;
        postString = [NSMutableString stringWithFormat:@"http://staticmagic.in/shobha_asar/v1/services/get_products"];
        _requesteAPI = nil;
        _requesteAPI = [[WebServiceParsing alloc] getDataFromURLStringForPost:postString];
        
        _requesteAPI.requestDelegate = self;
        
    }
    else
    {
        [WebServiceParsing InternetFailErrorMessage];
    }
    
}

-(void)getProductResponce:(id)getProductResponce
{
    NSMutableArray *resData=[[NSMutableArray alloc]init];
    
    [resData addObject:[getProductResponce objectForKey:@"STYLE_MASTER"]];
    
    NSMutableArray *STYLE_MASTERArray=[resData objectAtIndex:0];
    
    [self addSTYLE_MASTER:STYLE_MASTERArray];
    
    [indicatorrr removeFromSuperview];
    [indicatorrr setHidden:YES];
    
}

-(void)addCategoryDetails:(NSMutableArray *)categoryArray
{
    ShobhaAsarDataBase * dataBase = [[ShobhaAsarDataBase alloc]init];
    
    for (int i=0; i<[categoryArray count]; i++)
    {
        int cat_id=[[[categoryArray objectAtIndex:i] objectForKey:@"id"] intValue];
        NSString *names=[[categoryArray objectAtIndex:i] objectForKey:@"name"];
        NSString *image=[[categoryArray objectAtIndex:i] objectForKey:@"image"];
        int sequence=[[[categoryArray objectAtIndex:i] objectForKey:@"sequence"]intValue];
        NSString * image_pos=[[categoryArray objectAtIndex:i] objectForKey:@"image_pos"];
        NSString * is_new_collection=[[categoryArray objectAtIndex:i] objectForKey:@"is_new_collection"];
        NSString * section=[[categoryArray objectAtIndex:i] objectForKey:@"section"];
        NSString * background=[[categoryArray objectAtIndex:i] objectForKey:@"background"];
        int status=[[[categoryArray objectAtIndex:i] objectForKey:@"status"] intValue];
        NSString *parent_id=[[categoryArray objectAtIndex:i] objectForKey:@"parent_id"];
        int category_id=[[[categoryArray objectAtIndex:i] objectForKey:@"category_id"] intValue];
        NSString *created_ats=[[categoryArray objectAtIndex:i] objectForKey:@"created_at"];
        NSString *updated_ats=[[categoryArray objectAtIndex:i] objectForKey:@"updated_at"];
        
        
        [dataBase addCategory_cat_id:cat_id addCategory_name:names addCategory_image:image addCategory_sequence:sequence addCategory_image_pos:image_pos addCategory_is_new_collection:is_new_collection addCategory_section:section addCategory_background:background addCategory_status:status addCategory_parent_id:parent_id addCategory_category_id:category_id addCategory_created_at:created_ats addCategory_updated_at:updated_ats];
    }
    
}




-(void)onTapCategoryFullButton:(UIButton *)button
{
    ShobhaAsarDataBase *database=[[ShobhaAsarDataBase alloc]init];
    
    [database getCategoryData:button.tag];
    
    
     listingPage = [[self storyboard] instantiateViewControllerWithIdentifier:@"ViewController"];
     app.ProductArray=[[NSUserDefaults standardUserDefaults] valueForKey:@"categoryListingData"];
    listingPage.collectionName=button.currentTitle;
    NSLog(@"-->title Name %@",listingPage.collectionName);
    NSLog(@"-->title Name %@",button.currentTitle);
    
     [self.navigationController pushViewController:listingPage animated:YES];
  
    
    //[self switchToListingPage];
}

-(void)onTapCategoryHalfButton:(UIButton *)button
{
    ShobhaAsarDataBase *database=[[ShobhaAsarDataBase alloc]init];
    [database getCategoryData:button.tag];
    
    listingPage = [[self storyboard] instantiateViewControllerWithIdentifier:@"ViewController"];
    app.ProductArray=[[NSUserDefaults standardUserDefaults] valueForKey:@"categoryListingData"];
    listingPage.collectionName=button.currentTitle;
    [self.navigationController pushViewController:listingPage animated:YES];
}



-(void)onTapCollectionFullButton:(UIButton *)button
{
    
    ShobhaAsarDataBase *database=[[ShobhaAsarDataBase alloc]init];
    [database getCollectionData:button.tag];
    
    listingPage = [[self storyboard] instantiateViewControllerWithIdentifier:@"ViewController"];
    app.ProductArray=[[NSUserDefaults standardUserDefaults] valueForKey:@"collectionListingData"];
    listingPage.collectionName=button.currentTitle;
    [self.navigationController pushViewController:listingPage animated:YES];
 
    
    
}



- (void)onTapCollectionHalfButton:(UIButton*)button
{
   
    ShobhaAsarDataBase *database=[[ShobhaAsarDataBase alloc]init];
    [database getCollectionData:button.tag];
    
    listingPage = [[self storyboard] instantiateViewControllerWithIdentifier:@"ViewController"];
    app.ProductArray=[[NSUserDefaults standardUserDefaults] valueForKey:@"collectionListingData"];
    listingPage.collectionName=button.currentTitle;
    [self.navigationController pushViewController:listingPage animated:YES];
}


-(void)addCollectionDetails:(NSMutableArray *)collectionDetailsArray
{
    ShobhaAsarDataBase * dataBase = [[ShobhaAsarDataBase alloc]init];
    
    for (int i=0; i<[collectionDetailsArray count]; i++)
    {
        
        int collID=[[[collectionDetailsArray objectAtIndex:i] objectForKey:@"id"] intValue];
        NSString *names=[[collectionDetailsArray objectAtIndex:i] objectForKey:@"name"];
        NSString *image=[[collectionDetailsArray objectAtIndex:i] objectForKey:@"image"];
        int sequence=[[[collectionDetailsArray objectAtIndex:i] objectForKey:@"sequence"]intValue];
        NSString * image_pos=[[collectionDetailsArray objectAtIndex:i] objectForKey:@"image_pos"];
        NSString * is_new_collection=[[collectionDetailsArray objectAtIndex:i] objectForKey:@"is_new_collection"];
        NSString * section=[[collectionDetailsArray objectAtIndex:i] objectForKey:@"section"];
        NSString * background=[[collectionDetailsArray objectAtIndex:i] objectForKey:@"background"];
        int collection_id=[[[collectionDetailsArray objectAtIndex:i] objectForKey:@"collection_id"] intValue];
        int status=[[[collectionDetailsArray objectAtIndex:i] objectForKey:@"status"] intValue];
        
        
        
        
        NSString *created_ats=[[collectionDetailsArray objectAtIndex:i] objectForKey:@"created_at"];
        NSString *updated_ats=[[collectionDetailsArray objectAtIndex:i] objectForKey:@"updated_at"];
        
        
        
        [dataBase addCollection_coll_id:collID addCollection_name:names addCollection_image:image addCollection_sequence:sequence addCollection_image_pos:image_pos addCollection_is_new_collection:is_new_collection addCollection_section:section addCollection_background:background addCollection_collection_id:collection_id addCollection_status:status addCollection_created_at:created_ats addCollection_updated_at:updated_ats];
    }
}


-(void)addSTYLE_MASTER:(NSMutableArray *)STYLE_MASTERArray
{
    ShobhaAsarDataBase * dataBase = [[ShobhaAsarDataBase alloc]init];
    
    for (int i=0; i<[STYLE_MASTERArray count]; i++)
    {
        
        int productids=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"id"] intValue];
        NSString *names=[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"name"];
        int pieces=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"pieces"]intValue];
        int weights=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"weight"] intValue];
        int dia_pcss=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"dia_pcs"] intValue];
        int dia_wts=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"dia_wt"] intValue];
        int cst_pcss=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"cst_pcs"] intValue];
        int cst_wts=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"cst_wt"] intValue];
        NSString *image1s=[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"image1"];
        NSString *image2s=[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"image2"];
        NSString *image3s=[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"image3"];
        
        int in_stock_statuss=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"in_stock_status"] intValue];
        int metals=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"metal"] intValue];
        int karats=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"karat"] intValue];
        int sizes=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"size"] intValue];
        int qualitys=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"quality"] intValue];
        int prices=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"price"] intValue];
        int quality_prices=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"quality_price"] intValue];
        int category_ids=[[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"category_id"] intValue];
        NSString *style_ids=[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"style_id"];
        NSString *slash_nos=[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"slash_no"];
        NSString *location_ids=[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"location_id"];
        NSString *sub_category_ids=[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"sub_category_id"];
        NSString *created_ats=[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"created_at"];
        NSString *updated_ats=[[STYLE_MASTERArray objectAtIndex:i] objectForKey:@"updated_at"];
        
        
        
        [dataBase addProduct_ids:productids addProduct_name:names addProduct_pieces:pieces addProduct_weight:weights addProduct_dia_pcs:dia_pcss addProduct_dia_wt:dia_wts addProduct_cst_pcs:cst_pcss addProduct_cst_wt:cst_wts addProduct_image1:image1s addProduct_image2:image2s addProduct_image3:image3s addProduct_in_stock_status:in_stock_statuss addProduct_collection_id:category_ids addProduct_metal:metals addProduct_karat:karats addProduct_size:sizes addProduct_quality:qualitys addProduct_price:prices addProduct_quality_price:quality_prices addProduct_category_id:category_ids addProduct_style_id:style_ids addProduct_slash_no:slash_nos addProduct_location_id:location_ids addProduct_sub_category_id:sub_category_ids addProduct_created_at:created_ats addProduct_updated_at:updated_ats];
    }
}


-(void)failedToGetResponce:(NSError *)error
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"Internal server Error"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                }];
    [alert addAction:yesButton];
    [alert.view setTintColor:[UIColor colorWithRed:0.0/255.0 green:177.0/255.0 blue:176.0/288.0 alpha:1.0]];
    [self presentViewController:alert animated:YES completion:nil];
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
    
    
    
   
}

- (IBAction)onTapCategory_btn:(id)sender {
    
    tab_Btn.hidden=YES;
    tab_Btn2.hidden=NO;
    
    
    
}




-(void)switchToListingPage

{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *myVC = (ViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    listingPage.collectionName=[NSString stringWithFormat:@"%@",collTitleName];
    [self.navigationController pushViewController:myVC animated:YES];
}

- (IBAction)onTapCollectionButton:(id)sender {
    
    
    
    
    ShobhaAsarDataBase * dataBase = [[ShobhaAsarDataBase alloc]init];
    
    [dataBase getCollectionsPageDetails];
    
    
    
    collectData=[[NSUserDefaults standardUserDefaults] valueForKey:@"collectionData"];
    
    
    for (int i=0; i<collectData.count; i++) {
        
        if ([[[collectData objectAtIndex:i]valueForKey:@"section"]isEqualToString:@"full"])
        {
            [collectFullDataArr addObject:[collectData objectAtIndex:i]];
            
        }
        else if ([[[collectData objectAtIndex:i]valueForKey:@"section"]isEqualToString:@"half"])
        {
            
            [collectHalfData addObject:[collectData objectAtIndex:i]];
            
        }
        
        
    }
    
    
    int x=70;
    int y=60;
    int buttonHeight=200;
    int fullButtonW=620;
    int halfButtonW=290;
    
    int  ycoordi=collectFullDataArr.count*(buttonHeight+30)+collectHalfData.count *(buttonHeight+30);
    
    [scrollview setContentSize:CGSizeMake(self.view.frame.size.width, ycoordi)];
    
    if (collectFullDataArr.count>0) {
        
        for (int i=0; i<collectFullDataArr.count; i++) {
            
            
            UIButton *fullImageButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y,fullButtonW, buttonHeight)];
            
           // [fullImageButton setTitle:[NSString stringWithFormat:@"%@",[[collectFullDataArr objectAtIndex:i] valueForKey:@"name"]] forState:UIControlStateNormal];
            fullImageButton.titleLabel.textColor=[UIColor clearColor];
            
            [fullImageButton setBackgroundImage:[UIImage imageWithData:[[collectFullDataArr objectAtIndex:i] valueForKey:@"image"]] forState:UIControlStateNormal];
           // fullImageButton.backgroundColor=[UIColor colorWithHexString:[NSString stringWithFormat:@"%@",[[collectFullDataArr objectAtIndex:i] valueForKey:@"background"]]];
            
            //fullImageButton.backgroundColor=[UIColor whiteColor];
            [fullImageButton setTag:[[[collectFullDataArr objectAtIndex:i] valueForKey:@"collection_id"] integerValue]];
            [fullImageButton addTarget:self action:@selector(onTapCollectionFullButton:) forControlEvents:UIControlEventTouchUpInside];
            [scrollview addSubview:fullImageButton];
            y= y+buttonHeight+30;
        }
        
        
    }
    
    if (collectHalfData.count>0)
    {
        int  y=collectFullDataArr.count*(buttonHeight+30)+100;
        int  x=70;
        
        for (int i=0; i<collectHalfData.count; i++)
        {
            
            
            UIButton *halfButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y,halfButtonW, buttonHeight)];
            
            //[halfButton setTitle:[NSString stringWithFormat:@"%@",[[collectHalfData objectAtIndex:i] valueForKey:@"name"]] forState:UIControlStateNormal];
            halfButton.titleLabel.textColor=[UIColor clearColor];
            [halfButton setBackgroundImage:[UIImage imageWithData:[[collectHalfData objectAtIndex:i] valueForKey:@"image"]] forState:UIControlStateNormal];
            //halfButton.backgroundColor=[UIColor colorWithHexString:[NSString stringWithFormat:@"%@",[[collectHalfData objectAtIndex:i] valueForKey:@"background"]]];
            
            [halfButton setTag:[[[collectHalfData objectAtIndex:i] valueForKey:@"collection_id"] integerValue]];
            
            [halfButton addTarget:self action:@selector(onTapCollectionHalfButton:) forControlEvents:UIControlEventTouchUpInside];
            [scrollview addSubview:halfButton];
            
            
            x=x+halfButtonW+30;
            
            if (x>630)
            {
                y=y+buttonHeight+30;
                x=70;
            }
        }
    }
}

- (IBAction)onTapCategoryButton:(id)sender {
    [self getCategoryDefaultData];
}

    
-(void)getCategoryDefaultData
{
    
    ShobhaAsarDataBase * dataBase = [[ShobhaAsarDataBase alloc]init];
    
    [dataBase getCategoryPageDetails];
    
    categoryData=[[NSUserDefaults standardUserDefaults] valueForKey:@"categoryData"];
   
    
    
    for (int i=0; i<categoryData.count; i++) {
        
        if ([[[categoryData objectAtIndex:i]valueForKey:@"section"]isEqualToString:@"full"])
        {
            [categoryFullDataArr addObject:[categoryData objectAtIndex:i]];
            
        }
        else if ([[[categoryData objectAtIndex:i]valueForKey:@"section"]isEqualToString:@"half"])
        {
            
            [categoryHalfData addObject:[categoryData objectAtIndex:i]];
            
        }
        
        
    }
    
    
    int x=70;
    int y=60;
    int buttonHeight=200;
    int fullButtonW=620;
    int halfButtonW=290;
    
    int  ycoordi=categoryFullDataArr.count*(buttonHeight+30)+categoryHalfData.count *(buttonHeight+30);
    
    [scrollview setContentSize:CGSizeMake(self.view.frame.size.width, ycoordi)];
    
    if (categoryFullDataArr.count>0) {
        
        for (int i=0; i<categoryFullDataArr.count; i++) {
            
            
            UIButton *fullImageButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y,fullButtonW, buttonHeight)];
            
            [fullImageButton setBackgroundImage:[UIImage imageWithData:[[categoryFullDataArr objectAtIndex:i] valueForKey:@"image"]] forState:UIControlStateNormal];
            [fullImageButton setTitle:[NSString stringWithFormat:@"%@",[[categoryFullDataArr objectAtIndex:i] valueForKey:@"name"]] forState:UIControlStateNormal];
            fullImageButton.titleLabel.hidden=YES;
            fullImageButton.titleLabel.textColor=[UIColor clearColor];
            //fullImageButton.backgroundColor=[UIColor colorWithHexString:[NSString stringWithFormat:@"%@",[[categoryFullDataArr objectAtIndex:i] valueForKey:@"background"]]];
             //fullImageButton.backgroundColor=[UIColor whiteColor];
            [fullImageButton setTag:[[[categoryFullDataArr objectAtIndex:i] valueForKey:@"category_id"] integerValue]];
            
            [fullImageButton addTarget:self action:@selector(onTapCategoryFullButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview addSubview:fullImageButton];
            y= y+buttonHeight+30;
        }
        
        
    }
    
    if (categoryHalfData.count>0)
    {
        int  y=categoryFullDataArr.count*(buttonHeight+30)+100;
        int  x=70;
        
        for (int i=0; i<categoryHalfData.count; i++)
        {
            
            
            UIButton *halfButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y,halfButtonW, buttonHeight)];
            
            [halfButton setTitle:[NSString stringWithFormat:@"%@",[[categoryHalfData objectAtIndex:i] valueForKey:@"name"]] forState:UIControlStateNormal];
            halfButton.titleLabel.textColor=[UIColor clearColor];
            halfButton.titleLabel.hidden=YES;
            [halfButton setBackgroundImage:[UIImage imageWithData:[[categoryHalfData objectAtIndex:i] valueForKey:@"image"]] forState:UIControlStateNormal];
            //halfButton.backgroundColor=[UIColor colorWithHexString:[NSString stringWithFormat:@"%@",[[categoryHalfData objectAtIndex:i] valueForKey:@"background"]]];
            
            [halfButton setTag:[[[categoryHalfData objectAtIndex:i] valueForKey:@"category_id"] integerValue]];
            
            [halfButton addTarget:self action:@selector(onTapCategoryHalfButton:) forControlEvents:UIControlEventTouchUpInside];
            [scrollview addSubview:halfButton];
            
            
            x=x+halfButtonW+30;
            
            if (x>630)
            {
                y=y+buttonHeight+30;
                x=70;
            }
            
        }
    }

}
@end
