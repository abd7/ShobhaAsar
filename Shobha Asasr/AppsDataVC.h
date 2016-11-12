//
//  AppsDataVC.h
//  Shobha Asasr
//
//  Created by Ascra on 11/11/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceParsing.h"
#import "ShobhaAsarDataBase.h"
@interface AppsDataVC : UIViewController<WebServiceParsingDelegate>
@property (nonatomic, retain)  WebServiceParsing   * requesteAPI;
//@property NSMutableArray *productid,*name,*pieces,*weight,*dia_pcs,*dia_wt,*cst_pcs,*cst_wt,*image1,*image2,*image3,*in_stock_status,*collection_id,*metal,*karat,*size,*quality,*price,*quality_price,*category_id,*style_id,*slash_no,*location_id,*sub_category_id,*created_at,*updated_at;

-(void)addSTYLE_MASTER:(NSMutableArray *)STYLE_MASTERArray;
-(void)addCollectionDetails:(NSMutableArray *)collectionDetailsArray;
-(void)addCategoryDetails:(NSMutableArray *)categoryArray;
@end
