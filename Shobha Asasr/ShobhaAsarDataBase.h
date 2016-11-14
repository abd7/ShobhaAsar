//
//  ShobhaAsarDataBase.h
//  Shobha Asasr
//
//  Created by Ascra on 11/11/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ShobhaAsarDataBase : NSObject
{
  
        
        NSInteger proID;
        NSInteger cate_ID;
        NSInteger coll_ID;
    
}
-(void)getinitialPageData;

-(void)getCollectionsPageDetails;
-(void)getCategoryPageDetails;

+(void)getInitialDataToDisplay:(NSString *)dbpath;


//Add All products

-(void)addProduct_ids:(int)proid addProduct_name:(NSString *)name addProduct_pieces:(int)pieces addProduct_weight:(int)weight addProduct_dia_pcs:(int)dia_pcs addProduct_dia_wt:(int)dia_wt addProduct_cst_pcs:(int)cst_pcs addProduct_cst_wt:(int)cst_wt addProduct_image1:(NSString *)image1 addProduct_image2:(NSString *)image2 addProduct_image3:(NSString *)image3 addProduct_in_stock_status:(int)in_stock_status addProduct_collection_id:(int)collection_id addProduct_metal:(int)metal addProduct_karat:(int)karat addProduct_size:(int)size addProduct_quality:(int)quality addProduct_price:(int)price addProduct_quality_price:(int)quality_price  addProduct_category_id:(int)category_id addProduct_style_id:(NSString *)style_id addProduct_slash_no:(NSString *)slash_no addProduct_location_id:(NSString *)location_id addProduct_sub_category_id:(NSString *)sub_category_id addProduct_created_at:(NSString *)created_at addProduct_updated_at:(NSString *)updated_at;


//Add Category Data

-(void)addCategory_cat_id:(int)cat_id addCategory_name:(NSString*)name addCategory_image:(NSString*)image addCategory_sequence:(int)sequence addCategory_image_pos:(NSString*)image_pos addCategory_is_new_collection:(NSString*)is_new_collection addCategory_section:(NSString*)section addCategory_background:(NSString*)background addCategory_status:(int)status addCategory_parent_id:(NSString*)parent_id addCategory_category_id:(int)category_id addCategory_created_at:(NSString*)created_at addCategory_updated_at:(NSString*)updated_at;


//Add Collection Data

-(void)addCollection_coll_id:(int)coll_id addCollection_name:(NSString *)name addCollection_image:(NSString*)image addCollection_sequence:(int)sequence addCollection_image_pos:(NSString*)image_pos addCollection_is_new_collection:(NSString*)is_new_collection addCollection_section:(NSString*)section addCollection_background:(NSString*)background addCollection_collection_id:(int)collection_id addCollection_status:(int)status addCollection_created_at:(NSString*)created_at addCollection_updated_at:(NSString*)updated_at;

//add  Cart Data
-(void)addToCart_productid:(int)productID addToCart_quantity:(int)quantity addToCart_userEmail:(NSString *)useremail;

//add Wishlist Data

-(void)addToWishlist_productid:(int)productid addToWishlist_quantity:(int)quantity addToWishlist_userEmail:(NSString *)useremail;

@end
