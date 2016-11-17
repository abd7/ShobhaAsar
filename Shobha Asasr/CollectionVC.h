//
//  CollectionVC.h
//  Shobha Asasr
//
//  Created by Ascra on 10/24/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceParsing.h"
#import "ViewController.h"
#import "ShobhaAsarDataBase.h"
#import "Constant.h"
@class AppDelegate;

@interface CollectionVC : UIViewController<WebServiceParsingDelegate,UIApplicationDelegate>
{
    AppDelegate *app;
    UIButton *tab_Btn,*tab_Btn2;
  
    IBOutlet UIButton *collection_btn;
    IBOutlet UIButton *category_btn;
    IBOutlet UIView *underLineView;
   
    IBOutlet UIActivityIndicatorView *indicator;
}




@property (nonatomic, retain)  WebServiceParsing   * requesteAPI;
@property NSMutableDictionary *allProductsDic;
@property NSMutableArray *priceArr,*stockArr,*style_id,*product_idArray,*imageArr;





-(void)addSTYLE_MASTER:(NSMutableArray *)STYLE_MASTERArray;
-(void)addCollectionDetails:(NSMutableArray *)collectionDetailsArray;
-(void)addCategoryDetails:(NSMutableArray *)categoryArray;



- (IBAction)onTapCollectionButton:(id)sender;

- (IBAction)onTapCategoryButton:(id)sender;




@end
