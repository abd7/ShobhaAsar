//
//  ViewController.m
//  Shobha Asasr
//
//  Created by AscratechMacmini on 13/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "Constant.h"
#import "UIButton+Badge.h"
#import "AppDelegate.h"

@interface ViewController ()

{
    UIView *detailpage;
    UIView *TabBarIndicatorView;
    
    ProductDetailViewController *productDetailsPage;
    WishListVC *wishlistvc;
    MyCartVC *myCartvc;
    ImageCollectionViewCell *cell;
    
    UIButton *tab_Btn,*tab_Btn2;
    ImageCollectionViewCell *imageCell;
    CollectionVC *collectionvc;
    
   NSURLSession * urlSession;
   NSURLSessionConfiguration * urlSessionConfig;
   NSURLSessionDataTask * collectionDataTask;
   NSMutableURLRequest * mutableReq;
    
    NSInteger indexVal;
    NSString *urlName;
    
    NSString *proID;
    NSInteger proIdCount;
    NSMutableArray *cartSave,*wishSave;
    NSMutableDictionary *cartPostData;
}
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


@end

@implementation ViewController
@synthesize topMenuView,collection_btn,category_btn;

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    [self TopViewUnderLine];
    
    [self tabButton];
    
    app = [[UIApplication sharedApplication] delegate];
    
    [self cartListBadgeCheck];
    [self wishListBadgeCheck];
    
    //self.productDetailsPage=[[ProductDetailViewController alloc]init];

    _collectionviewimgs.backgroundColor = [UIColor clearColor];
    _collectionTitleLabel.text=self.collectionName;
    
    NSLog(@"%@",self.collectionName);
    
 
    _collectionviewimgs.delegate=self;
    _collectionviewimgs.dataSource=self;
 
    
    
    tab_Btn.hidden=YES;
    tab_Btn2.hidden=YES;
    
    //filter_btn.layer.cornerRadius=filter_btn.frame.size.height/2;
    filter_btn.clipsToBounds=YES;
    
    urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig];
    cartSave=[[NSMutableArray alloc]init];
    wishSave=[[NSMutableArray alloc]init];
    cartPostData=[[NSMutableDictionary alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)tapOnceOnCartButton
{
    
}
-(void)tapTwiceOnCartButton
{
    
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

-(void)tabButton
{
    tab_Btn=[[UIButton alloc]initWithFrame:CGRectMake(collection_btn.frame.origin.x,0,collection_btn.frame.size.width, 3)];
    
    tab_Btn.backgroundColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0];
    [TabBarIndicatorView addSubview:tab_Btn];
    
    tab_Btn2=[[UIButton alloc]initWithFrame:CGRectMake(category_btn.frame.origin.x,0,category_btn.frame.size.width, 3)];
    tab_Btn2.backgroundColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0];
    [TabBarIndicatorView addSubview:tab_Btn2];
}

-(void)TopViewUnderLine
{
    TabBarIndicatorView=[[UIView alloc]initWithFrame:CGRectMake(0.0f, topMenuView.frame.size.height+20, topMenuView.frame.size.width, 3.0f)];
    TabBarIndicatorView.backgroundColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:0.3];
    [self.view addSubview:TabBarIndicatorView];
    
   
}

-(void)onTapAddTocart
{
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrayForimgs.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (![[self.stockArray objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
        
        
    }else
    {
        [cell.inStockTag setBackgroundImage:[UIImage imageNamed:@"In stock.png"] forState:UIControlStateNormal];
    }
    
    
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
   NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.arrayForimgs objectAtIndex:indexPath.row]]];
  cell.jewelimg.image=[UIImage imageWithData:imageData] ;
    
    
    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"HeartCell.png"] forState:UIControlStateNormal];
    
    cell.cartbtnoutlet.tag=indexPath.row;
    cell.wishListButton.tag=indexPath.row;
    NSLog(@"cartButt-->%ld",(long)cell.cartbtnoutlet.tag);
    
    [cell.cartbtnoutlet setBackgroundImage:[UIImage imageNamed:@"CartsCell.png"] forState:UIControlStateNormal];
    [cell.cartbtnoutlet addTarget:self action:@selector(onTapCartButtons:) forControlEvents:UIControlEventTouchUpInside];
    [cell.wishListButton addTarget:self action:@selector(onTapWishListButton:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.priceLabel.text=[NSString stringWithFormat:@"%@",[self.priceArray objectAtIndex:indexPath.row]];
    cell.styleLabel.text=[NSString stringWithFormat:@"Style No. %@",[self.styleArray objectAtIndex:indexPath.row]];
    
    NSLog(@"%@",[self.priceArray objectAtIndex:indexPath.row]);
    cell.cellview.layer.borderColor=[UIColor colorWithRed:0.91 green:0.82 blue:0.63 alpha:1.0].CGColor;
    cell.cellview.layer.borderWidth=1.5;
    


    return  cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    indexVal=indexPath.row;
   
   productDetailsPage.indexVal=indexPath.row;
    
    productDetailsPage=[[self storyboard]instantiateViewControllerWithIdentifier:@"productid"];
    
    productDetailsPage.mainImageArray=[self.arrayForimgs objectAtIndex:indexPath.row];
    
    productDetailsPage.cartImageArray = cartSave;
    
    productDetailsPage.wishListImageArray=wishSave;

    productDetailsPage.productStyleNo=[self.styleArray objectAtIndex:indexPath.row];
    
    productDetailsPage.productTypeName= self.collectionName;
  
    [self.navigationController pushViewController:productDetailsPage animated:YES];
  
}



- (IBAction)onTapCollection_btn:(id)sender {
    
    tab_Btn.hidden=NO;
    tab_Btn2.hidden=YES;
    
}

- (IBAction)onTapCategory_btn:(id)sender {
    
    tab_Btn.hidden=YES;
    tab_Btn2.hidden=NO;
    
//    collectionvc=[[self storyboard]instantiateViewControllerWithIdentifier:@"collectionvc"];
//    [self presentViewController:collectionvc animated:YES completion:nil];
    
}


- (IBAction)onTapLeftMenu_btn:(id)sender {
  
     [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)onTapFilter_btn:(id)sender {
    
    
}

- (IBAction)onTapWishList_btn:(id)sender
{
    if (app.wishListCount.count==0)
    {
   
        listingWishListButton.userInteractionEnabled=NO;
    }
    else{
        wishlistvc=[[self storyboard]instantiateViewControllerWithIdentifier:@"wishlistvc"];
        
        wishlistvc.wishListvcArray=wishSave;
        
        [self.navigationController pushViewController:wishlistvc animated:YES];
    }
}



- (IBAction)onTapCart_btn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myCartvc = (MyCartVC *)[storyboard instantiateViewControllerWithIdentifier:@"mycart"];
    myCartvc.myCartImageArray=cartSave;
    
    [self.navigationController pushViewController:myCartvc animated:YES];
}

-(void)wishListBadgeCheck
{
    if([app.wishListCount count]>0)
    {
        listingWishListButton.badgeValue=[NSString stringWithFormat:@"%lu", (unsigned long)app.wishListCount.count];
    }

}

-(void)cartListBadgeCheck
{
    if([app.cartListCount count]>0)
    {
        listingCartBtn.badgeValue=[NSString stringWithFormat:@"%lu", (unsigned long)app.cartListCount.count];
    }
    
}


-(void)onTapWishListButton:(UIButton *)sender
{

    UIImage *image = [UIImage imageNamed:@"redHeart.png"];
    [sender setImage:image forState:UIControlStateNormal];
    
    
    if (![app.wishListCount containsObject:[self.arrayForimgs objectAtIndex:sender.tag]])
    {
        
        [wishSave addObject:[self.arrayForimgs objectAtIndex:sender.tag]];
        
        [app.wishListCount addObject:[self.arrayForimgs objectAtIndex:sender.tag]];
        
        
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Already selected!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    

    [self wishListBadgeCheck];
    
   
}

//- (IBAction)onTapCart_btn:(UIButton*)sender {

 -(void)onTapCartButtons:(UIButton*)sender
{
    
 
    UIImage *image = [UIImage imageNamed:@"Cart Btn.png"];
    [sender setImage:image forState:UIControlStateNormal];
    
    if (![app.cartListCount containsObject:[self.arrayForimgs objectAtIndex:sender.tag]])
    {
        
        [cartSave addObject:[self.arrayForimgs objectAtIndex:sender.tag]];
        
        [app.cartListCount addObject:[self.arrayForimgs objectAtIndex:sender.tag]];
        
         [self cartListBadgeCheck];
        
        
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Already selected!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

    
    

    proID=[NSString stringWithFormat:@"%@",[_productID objectAtIndex:indexVal]];
    //[cartSave addObject:[self.arrayForimgs objectAtIndex:sender.tag]];
    
    //[app.cartListCount addObject:cartSave];
    proIdCount=cartSave.count;
   
    _paramArray=[[NSMutableArray alloc]init];
    
    NSMutableDictionary *postDIc = [[NSMutableDictionary alloc]init];
    
    
    [postDIc setObject:proID forKey:@"product_id"];
    [postDIc setObject:[NSString stringWithFormat:@"%ld",(long)proIdCount] forKey:@"quantity"];
    [postDIc setObject:@"m@m.com" forKey:@"user_email"];
    
   
    [_paramArray addObject:postDIc];
    
    [cartPostData setObject:_paramArray forKey:@"product_data"];
  
   
    
   urlName=[BaseUrl stringByAppendingString:addtocart];
    
   
    
    [app customerLoginCheck];
    
    [self authenticateWithServer];
    
}



-(void)authenticateWithServer
{
  
        
    
    NSString * user_email=@"amit@ascratech.com";
    NSString * quantity=@"1";
    NSString *product_id=@"3";
    
    
    NSMutableDictionary *postDIc = [[NSMutableDictionary alloc]init];
    
    
    [postDIc setObject:product_id forKey:@"product_id"];
//    [postDIc setObject:quantity forKey:@"quantity"];
//    [postDIc setObject:user_email forKey:@"user_email"];
//    
    NSMutableArray *paramArr=[[NSMutableArray alloc]init];
    NSMutableDictionary *postDIcss = [[NSMutableDictionary alloc]init];
    [paramArr addObject:postDIc];
    [postDIcss setObject:paramArr forKey:@"product_data"];
// 
    NSData *data = [NSJSONSerialization dataWithJSONObject:postDIc options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://staticmagic.in/shobha_asar/v1/services/addtocart"]];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *dataTask = [session uploadTaskWithRequest: request
                                                             fromData: data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                 if (error)
                                                                 {
                                                                     return ;
                                                                 }
                                                        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                                 NSLog(@"-addCartPost %@",json);

                                                             }];
    
    
      [dataTask resume];
//        
//        mutableReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[BaseUrl stringByAppendingString:addtocart]]];
//        
//        
//        [mutableReq setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [mutableReq setHTTPMethod:@"POST"];
//        
//        NSString *post = [[NSString alloc] initWithFormat:@"%@",postDIcss];
//        NSLog(@"-addCartPost %@",post);
//        
//        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
//        
//        [mutableReq setValue:postLength forHTTPHeaderField:@"Content-Length"];
//        
//        [mutableReq setHTTPBody:postData];
//        
//        
//        collectionDataTask = [urlSession dataTaskWithRequest:mutableReq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            
//            
//            NSLog(@"got response from server %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
//            NSDictionary*servDic= [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSLog(@"---Response from server %@",servDic);
//            
//        }];
//        
//        [collectionDataTask resume];
//        
//    
//    
//    
    
}

@end
