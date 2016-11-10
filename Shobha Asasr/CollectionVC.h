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
#import "Constant.h"
@class AppDelegate;

@interface CollectionVC : UIViewController<WebServiceParsingDelegate>
{
    AppDelegate *app;
    UIButton *tab_Btn,*tab_Btn2;
    IBOutlet UIView *underLineView;
    
    IBOutlet UIButton *collection_btn;
    IBOutlet UIButton *category_btn;
    IBOutlet UIButton *wishList_btn;
    IBOutlet UIButton *cart_btn;
}

@property (nonatomic, retain)  WebServiceParsing   * requesteAPI;



@property (strong, nonatomic) IBOutlet UIButton *necklace_btn;
@property (strong, nonatomic) IBOutlet UIButton *pendant_btn;

@property (strong, nonatomic) IBOutlet UIButton *ring_btn;
@property (strong, nonatomic) IBOutlet UIButton *earrings_btn;
@property (strong, nonatomic) IBOutlet UIButton *bracelets_btn;
@property (strong, nonatomic) IBOutlet UIButton *bangles_btn;

@property NSMutableDictionary *allProductsDic;


- (IBAction)onTapCollection_btn:(id)sender;
- (IBAction)onTapCategory_btn:(id)sender;
- (IBAction)onTapNecklace_btn:(id)sender;
- (IBAction)onTapRings_btn:(id)sender;
- (IBAction)onTapEarrings_btn:(id)sender;
- (IBAction)onTapBracelets_btn:(id)sender;
- (IBAction)onTapBangles_btn:(id)sender;
- (IBAction)onTapPendant_btn:(id)sender;

@property NSURLSession * urlSession;
@property NSURLSessionConfiguration * urlSessionConfig;
@property NSURLSessionDataTask * collectionDataTask;
@property NSMutableURLRequest * mutableReq;




@property NSMutableArray *priceArr,*stockArr,*style_id,*product_idArray,*imageArr;


@end
