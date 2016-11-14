//
//  AppsDataVC.m
//  Shobha Asasr
//
//  Created by Ascra on 11/11/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "AppsDataVC.h"
#import "WebServiceParsing.h"
#import "Reachability.h"
#import "Constant.h"
#import "ShobhaAsarDataBase.h"
#import <sqlite3.h>
#import "UIColor+ColorCategory.h"



@interface AppsDataVC ()
{
    UIScrollView *scrollview;
}

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@end

@implementation AppsDataVC


- (void)viewDidLoad {
    [super viewDidLoad];
     [self callWebService];
    [self getCollectionData];
    [self getcategoryData];
    
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    
    [self.view addSubview:scrollview];
 
}
- (IBAction)fetchData:(id)sender
{
   
    
}

-(void)getCollectionData
{
    
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

}

-(void)getcategoryData
{
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
    NSLog(@"--response Data %@",getProductResponce);
    
    NSMutableArray *resData=[[NSMutableArray alloc]init];
   [resData addObject:[getProductResponce objectForKey:@"STYLE_MASTER"]];
    NSMutableArray *STYLE_MASTERArray=[resData objectAtIndex:0];
    
   [self addSTYLE_MASTER:STYLE_MASTERArray];
    
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

- (IBAction)onTapCategory_btn:(id)sender {
    
    ShobhaAsarDataBase * dataBase = [[ShobhaAsarDataBase alloc]init];
    
    [dataBase getCategoryPageDetails];
    
    
    NSMutableArray *fullDataArr=[[NSMutableArray alloc]init];
    NSMutableArray *halfData=[[NSMutableArray alloc]init];
    
    
    NSMutableArray *ascendingData=[[NSMutableArray alloc]init];
    
    NSMutableArray *categoryData=[[NSUserDefaults standardUserDefaults] valueForKey:@"categoryData"];
    

    
    NSLog(@"--CollectionData %lu",(unsigned long)categoryData.count);
    
    int seqC=1;
    int x=70;
    int y=60;
    int buttonHeight=200;
    int fullButtonW=630;
    int halfButtonW=300;
    
    int  ycoordi=categoryData.count*(buttonHeight+30)+halfData.count *(buttonHeight+30);
    
    [scrollview setContentSize:CGSizeMake(self.view.frame.size.width, ycoordi)];
    
    for (int i=0; i<categoryData.count; i++) {
        
        if ([[[categoryData objectAtIndex:i]valueForKey:@"sequence"] isEqual:[NSString stringWithFormat:@"%d",i]])
           
        {
            [ascendingData addObject:[categoryData objectAtIndex:i]];
            NSLog(@"-->%@",ascendingData);
        }
            if ([[[categoryData objectAtIndex:i]valueForKey:@"section"]isEqualToString:@"full"]) {
                
                UIButton *fullImageButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y,fullButtonW, buttonHeight)];
                
                [fullImageButton setBackgroundImage:[UIImage imageWithData:[[categoryData objectAtIndex:i] valueForKey:@"image"]] forState:UIControlStateNormal];
                fullImageButton.backgroundColor=[UIColor colorWithHexString:[NSString stringWithFormat:@"%@",[[categoryData objectAtIndex:i] valueForKey:@"background"]]];
               [scrollview addSubview:fullImageButton];
                y= y+buttonHeight+30;

                
            }
            else if ([[[categoryData objectAtIndex:i]valueForKey:@"section"]isEqualToString:@"half"])
            {
                UIButton *halfButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y,halfButtonW, buttonHeight)];
                
                
                [halfButton setBackgroundImage:[UIImage imageWithData:[[categoryData objectAtIndex:i] valueForKey:@"image"]] forState:UIControlStateNormal];
                halfButton.backgroundColor=[UIColor colorWithHexString:[NSString stringWithFormat:@"%@",[[categoryData objectAtIndex:i] valueForKey:@"background"]]];
                [[halfButton imageView] setContentMode: UIViewContentModeScaleAspectFit];
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

        
//            
//        }
//        else if ([[[categoryData objectAtIndex:i]valueForKey:@"section"]isEqualToString:@"half"])
//        {
//            
//            [halfData addObject:[categoryData objectAtIndex:i]];
//            
//        }
//        
//        
//    }
    
//    
//    int x=70;
//    int y=60;
//    int buttonHeight=200;
//    int fullButtonW=630;
//    int halfButtonW=300;
//    
//    int  ycoordi=fullDataArr.count*(buttonHeight+30)+halfData.count *(buttonHeight+30);
//    
//    [scrollview setContentSize:CGSizeMake(self.view.frame.size.width, ycoordi)];
//    
//    if (fullDataArr.count>0) {
//        
//        for (int i=0; i<fullDataArr.count; i++) {
//            
//           UIButton *fullImageButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y,fullButtonW, buttonHeight)];
//            
//            //[fullImageButton setTitle:[NSString stringWithFormat:@"%@",[[fullDataArr objectAtIndex:i] valueForKey:@"name"]] forState:UIControlStateNormal];
//            [fullImageButton setBackgroundImage:[UIImage imageWithData:[[fullDataArr objectAtIndex:i] valueForKey:@"image"]] forState:UIControlStateNormal];
//            fullImageButton.backgroundColor=[UIColor colorWithHexString:[NSString stringWithFormat:@"%@",[[fullDataArr objectAtIndex:i] valueForKey:@"background"]]];
//            [[fullImageButton imageView] setContentMode: UIViewContentModeScaleAspectFit];
//            
//            [scrollview addSubview:fullImageButton];
//            y= y+buttonHeight+30;
//        }
//        
//        
//    }
//    
//    if (halfData.count>0)
//    {
//        int  y=fullDataArr.count*(buttonHeight+30)+100;
//        int  x=70;
//        
//        for (int i=0; i<halfData.count; i++)
//        {
//            
//            
//            UIButton *halfButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y,halfButtonW, buttonHeight)];
//            
//            //[halfButton setTitle:[NSString stringWithFormat:@"%@",[[halfData objectAtIndex:i] valueForKey:@"name"]] forState:UIControlStateNormal];
//            [halfButton setBackgroundImage:[UIImage imageWithData:[[halfData objectAtIndex:i] valueForKey:@"image"]] forState:UIControlStateNormal];
//            halfButton.backgroundColor=[UIColor colorWithHexString:[NSString stringWithFormat:@"%@",[[halfData objectAtIndex:i] valueForKey:@"background"]]];
//            [[halfButton imageView] setContentMode: UIViewContentModeScaleAspectFit];
//            [scrollview addSubview:halfButton];
//            
//            
//            x=x+halfButtonW+30;
//            
//            if (x>630)
//            {
//                y=y+buttonHeight+30;
//                x=70;
//            }
//            
//        }
//        
//        
//        
//        
//        
//        
//    }
//
    


- (IBAction)onTapCollection_btn:(id)sender {
    
    
    ShobhaAsarDataBase * dataBase = [[ShobhaAsarDataBase alloc]init];
    
    [dataBase getCollectionsPageDetails];
    
    NSMutableArray *fullDataArr=[[NSMutableArray alloc]init];
    NSMutableArray *halfData=[[NSMutableArray alloc]init];
    
    NSMutableArray *collectData=[[NSUserDefaults standardUserDefaults] valueForKey:@"collectionData"];
    
    NSLog(@"--CollectionData %lu",(unsigned long)collectData.count);

    
    for (int i=0; i<collectData.count; i++) {
        
     if ([[[collectData objectAtIndex:i]valueForKey:@"section"]isEqualToString:@"full"])
     {
             [fullDataArr addObject:[collectData objectAtIndex:i]];
         
     }
     else if ([[[collectData objectAtIndex:i]valueForKey:@"section"]isEqualToString:@"half"])
      {

            [halfData addObject:[collectData objectAtIndex:i]];
            
        }
        
        
    }
    

    int x=70;
    int y=60;
    int buttonHeight=190;
    int fullButtonW=620;
    int halfButtonW=290;
    
  int  ycoordi=fullDataArr.count*(buttonHeight+30)+halfData.count *(buttonHeight+30);
    
    [scrollview setContentSize:CGSizeMake(self.view.frame.size.width, ycoordi)];
    
    if (fullDataArr.count>0) {
        
        for (int i=0; i<fullDataArr.count; i++) {
            
            
            UIButton *fullImageButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y,fullButtonW, buttonHeight)];
            
            //[fullImageButton setTitle:[NSString stringWithFormat:@"%@",[[fullDataArr objectAtIndex:i] valueForKey:@"name"]] forState:UIControlStateNormal];
            [fullImageButton setBackgroundImage:[UIImage imageWithData:[[fullDataArr objectAtIndex:i] valueForKey:@"image"]] forState:UIControlStateNormal];
            fullImageButton.backgroundColor=[UIColor colorWithHexString:[NSString stringWithFormat:@"%@",[[fullDataArr objectAtIndex:i] valueForKey:@"background"]]];
            
            [scrollview addSubview:fullImageButton];
            y= y+buttonHeight+30;
        }
        
        
     }
    
    if (halfData.count>0)
    {
      int  y=fullDataArr.count*(buttonHeight+30)+100;
        int  x=70;
        
        for (int i=0; i<halfData.count; i++)
        {
            
            
            UIButton *halfButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y,halfButtonW, buttonHeight)];
           
            //[halfButton setTitle:[NSString stringWithFormat:@"%@",[[halfData objectAtIndex:i] valueForKey:@"name"]] forState:UIControlStateNormal];
            [halfButton setBackgroundImage:[UIImage imageWithData:[[halfData objectAtIndex:i] valueForKey:@"image"]] forState:UIControlStateNormal];
            halfButton.backgroundColor=[UIColor colorWithHexString:[NSString stringWithFormat:@"%@",[[halfData objectAtIndex:i] valueForKey:@"background"]]];
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
