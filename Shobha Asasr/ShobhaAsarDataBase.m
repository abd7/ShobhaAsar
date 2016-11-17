//
//  ShobhaAsarDataBase.m
//  Shobha Asasr
//
//  Created by Ascra on 11/11/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "ShobhaAsarDataBase.h"

#import <sqlite3.h>

static sqlite3 *database = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *detailStmt = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt * updatestmt = nil;

@implementation ShobhaAsarDataBase

+(void)getInitialDataToDisplay:(NSString *)dbpath
{
    
    if (sqlite3_open([dbpath UTF8String], &database)==SQLITE_OK)
    {
        const char*sql = "Select * from STYLE_MASTER";
        sqlite3_stmt * selectstmt;
        sqlite3_busy_timeout(database, 500);
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL)==SQLITE_OK)
        {
            while (sqlite3_step(selectstmt)== SQLITE_ROW)
            {
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                
                ShobhaAsarDataBase * Obj = [[ShobhaAsarDataBase alloc] initWithPrimaryKey:primaryKey];
                NSLog(@"%@",Obj);
                sqlite3_busy_timeout(database, 500);
            }
        }
        
        sqlite3_finalize(selectstmt);
    }
    else sqlite3_close(database);
}

-(NSString *)filePath
{
    NSString *documentsDir=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    
    return [documentsDir stringByAppendingPathComponent:@"shobhaasarDB.sqlite"];
}


-(BOOL)openDB
{
    if(sqlite3_open([[self filePath]UTF8String],&database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        return NO;
    }
    else
    {
        return YES;
    }
}
-(void)closeDB
{
    sqlite3_close(database);
    
}
-(id)initWithPrimaryKey:(NSInteger)pk
{
    self = [super init];
    if (self) {
       
    }
    return self;
    
}


+(void)finalizeStatements
{
    if (database)
    {
        sqlite3_close(database);
    }
    
}

#pragma Fetch Filter Data

-(void)getFilterData
{
    
    NSMutableArray  *collectionArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *string = @"";
    
    
    string = [NSString stringWithFormat:@"Select * From STYLE_MASTER"];
    
    const char *sql= [string cStringUsingEncoding:NSUTF8StringEncoding];
    if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
       
        
        NSMutableString *name = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 2)];
        
        
        NSNumber *szd = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 16)];
        
        NSMutableString *size = [[NSMutableString alloc] initWithFormat:@"%d",[szd intValue]];
        
        NSNumber *prc = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 18)];
        
        NSMutableString *price = [[NSMutableString alloc] initWithFormat:@"%d",[prc intValue]];
        
        NSNumber *instk = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 12)];
        
        NSMutableString *in_stock_status = [[NSMutableString alloc] initWithFormat:@"%d",[instk intValue]];
        
        
        
        
        [dict setValue:size forKey:@"size"];
        [dict setValue:name forKey:@"name"];
        [dict setValue:in_stock_status forKey:@"in_stock_status"];
        [dict setValue:price forKey:@"price"];
        
      
        [collectionArr addObject:[dict copy]];
        
        [[NSUserDefaults standardUserDefaults] setObject:collectionArr forKey:@"filterData"];
    }
    sqlite3_reset(detailStmt);
}




#pragma mark SELECT QUERY FOR Collection

-(void)getCollectionsPageDetails
{
    NSMutableArray  *collectionArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *string = @"";
    
    
    string = [NSString stringWithFormat:@"Select * From COLLECTION_MASTER"];
    
    const char *sql= [string cStringUsingEncoding:NSUTF8StringEncoding];
    if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        NSNumber *r1 = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 1)];
        
        NSMutableString *id = [[NSMutableString alloc] initWithFormat:@"%d",[r1 intValue]];
        
        NSMutableString *name = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 2)];
        
        // NSMutableString *image = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 3)];
        
         //NSData *imageData = [[NSData alloc] initWithBytes:sqlite3_column_blob(detailStmt, 3) length:sqlite3_column_bytes(detailStmt, 3)];
        
        int length = sqlite3_column_bytes(detailStmt, 3);
        NSData *imageData = [NSData dataWithBytes:sqlite3_column_blob(detailStmt, 3) length:length];
        
        NSNumber *secid = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 4)];
        
        NSMutableString *sequence = [[NSMutableString alloc] initWithFormat:@"%d",[secid intValue]];

        NSMutableString *image_pos = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 5)];
        NSMutableString *is_new_collection = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 6)];
        
        NSMutableString *section = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 7)];
        NSMutableString *background = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 8)];
        
        NSNumber *colid = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 9)];
        
        NSMutableString *collection_id = [[NSMutableString alloc] initWithFormat:@"%d",[colid intValue]];
        
        NSNumber *stat = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 10)];
        
        NSMutableString *status = [[NSMutableString alloc] initWithFormat:@"%d",[stat intValue]];
        
        NSMutableString *created_at = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 11)];
        NSMutableString *updated_at = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 12)];
        
        
        [dict setValue:id forKey:@"coll_id"];
        
        [dict setValue:name forKey:@"name"];
        
        [dict setValue:imageData forKey:@"image"];
        
        [dict setValue:sequence forKey:@"sequence"];
        
        [dict setValue:image_pos forKey:@"image_pos"];
        
        [dict setValue:is_new_collection forKey:@"is_new_collection"];
        
        [dict setValue:section forKey:@"section"];
        
        [dict setValue:background forKey:@"background"];
        
        [dict setValue:collection_id forKey:@"collection_id"];
        
        [dict setValue:status forKey:@"status"];
        
        [dict setValue:created_at forKey:@"created_at"];
        
        [dict setValue:updated_at forKey:@"updated_at"];
        
        
        [collectionArr addObject:[dict copy]];
        
        [[NSUserDefaults standardUserDefaults] setObject:collectionArr forKey:@"collectionData"];
        
       
        

        
    }
    //Reset the detail statement.
    sqlite3_reset(detailStmt);
    //return collectionArr;
}

#pragma mark SELECT QUERY FOR Category

-(void)getCategoryPageDetails
{
    NSMutableArray  *categoryArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *catDict = [[NSMutableDictionary alloc] init];
    NSString *string = @"";
    
    
    string = [NSString stringWithFormat:@"Select * From CATEGORY_MASTER"];
    
    const char *sql= [string cStringUsingEncoding:NSUTF8StringEncoding];
    if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        
        NSNumber *catid = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 1)];
        
        NSMutableString *cat_id = [[NSMutableString alloc] initWithFormat:@"%d",[catid intValue]];
        
        NSMutableString *name = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 2)];
        
        //NSMutableString *image = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 3)];
        
        NSData *image = [[NSData alloc] initWithBytes:sqlite3_column_blob(detailStmt, 3) length:sqlite3_column_bytes(detailStmt, 3)];
        
        //NSMutableString *image_url = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 4)];
        
        NSNumber *secid = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 4)];
        
        NSMutableString *sequence = [[NSMutableString alloc] initWithFormat:@"%d",[secid intValue]];
        
        NSMutableString *image_pos = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 5)];
        
        NSMutableString *is_new_collection = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 6)];
        
        NSMutableString *section = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 7)];
        NSMutableString *background = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 8)];
        
        NSNumber *stat = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 9)];
        
        NSMutableString *status = [[NSMutableString alloc] initWithFormat:@"%d",[stat intValue]];
        
        NSNumber *parentid = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 10)];
        
        NSMutableString *parent_id = [[NSMutableString alloc] initWithFormat:@"%d",[parentid intValue]];
        
        
        NSNumber *categoryid = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 11)];
        
        NSMutableString *category_id = [[NSMutableString alloc] initWithFormat:@"%d",[categoryid intValue]];
        
       NSMutableString *created_at = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 12)];
        NSMutableString *updated_at = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 13)];
        
        
        [catDict setValue:cat_id forKey:@"cat_id"];
        
        [catDict setValue:name forKey:@"name"];
        
        [catDict setValue:image forKey:@"image"];
        
        [catDict setValue:sequence forKey:@"sequence"];
        
        [catDict setValue:image_pos forKey:@"image_pos"];
        
        [catDict setValue:is_new_collection forKey:@"is_new_collection"];
        
        [catDict setValue:section forKey:@"section"];
        
        [catDict setValue:background forKey:@"background"];
        
        [catDict setValue:status forKey:@"status"];
        
         [catDict setValue:parent_id forKey:@"parent_id"];
        
        [catDict setValue:category_id forKey:@"category_id"];
        
       [catDict setValue:created_at forKey:@"created_at"];
        
        [catDict setValue:updated_at forKey:@"updated_at"];
        
        
        [categoryArr addObject:[catDict copy]];
        
        [[NSUserDefaults standardUserDefaults] setObject:categoryArr forKey:@"categoryData"];
        
        
    }
    //Reset the detail statement.
    sqlite3_reset(detailStmt);
    //return collectionArr;
}


//-(void)getinitialPageData
//{
//    NSString *string = @"";
//    
//    
//    string = [NSString stringWithFormat:@"Select * From CATEGORY_MASTER"];
//    const char *sql= [string cStringUsingEncoding:NSUTF8StringEncoding];
//    if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
//        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
//    while (sqlite3_step(detailStmt) == SQLITE_ROW)
//    {
//        NSMutableString *feedStatus = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 38)];
//        NSMutableString *show_social_feeds = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 39)];
//        
//        NSLog(@"%@",feedStatus);
//        NSLog(@"%@",show_social_feeds);
//        
//    }
//    //Reset the detail statement.
//    sqlite3_reset(detailStmt);
//
//}

-(void)addProduct_ids:(int)proid addProduct_name:(NSString *)name addProduct_pieces:(int)pieces addProduct_weight:(int)weight addProduct_dia_pcs:(int)dia_pcs addProduct_dia_wt:(int)dia_wt addProduct_cst_pcs:(int)cst_pcs addProduct_cst_wt:(int)cst_wt addProduct_image1:(NSString *)image1 addProduct_image2:(NSString *)image2 addProduct_image3:(NSString *)image3 addProduct_in_stock_status:(int)in_stock_status addProduct_collection_id:(int)collection_id addProduct_metal:(int)metal addProduct_karat:(int)karat addProduct_size:(int)size addProduct_quality:(int)quality addProduct_price:(int)price addProduct_quality_price:(int)quality_price  addProduct_category_id:(int)category_id addProduct_style_id:(NSString *)style_id addProduct_slash_no:(NSString *)slash_no addProduct_location_id:(NSString *)location_id addProduct_sub_category_id:(NSString *)sub_category_id addProduct_created_at:(NSString *)created_at addProduct_updated_at:(NSString *)updated_at
{
    int record_exists = 0;
    
    NSData *  imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:image1]];
    NSData *  imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:image2]];
    NSData *  imageData3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:image3]];
    
    
    NSString *sqlStrrecord = [NSString stringWithFormat:@"select * from STYLE_MASTER where proid='%d'",proid];
    
    const char *sqlsqlRecord = [sqlStrrecord cStringUsingEncoding:NSUTF8StringEncoding];
    
    if(sqlite3_prepare_v2(database, sqlsqlRecord, -1, &detailStmt, NULL) != SQLITE_OK)
        
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        record_exists=1;
        const char * sql = "delete from STYLE_MASTER where proid = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"error while creating delete statement.'%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_int(deleteStmt, 1, proid);
        
        if (SQLITE_DONE!= sqlite3_step(deleteStmt))
            NSAssert1(0, @"errror while deleting.'%s'", sqlite3_errmsg(database));
    }
    const char *sql = "insert into STYLE_MASTER(proid,name,pieces,weight,dia_pcs,dia_wt,cst_pcs,cst_wt,image1,image2,image3,in_stock_status,collection_id,metal,karat,size,quality,price,quality_price,category_id,style_id,slash_no,location_id,sub_category_id,created_at,updated_at) Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    
    
    sqlite3_bind_int(addStmt, 1, proid);
    sqlite3_bind_text(addStmt, 2, [name UTF8String], -1, SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 3, pieces);
    sqlite3_bind_int(addStmt, 4, weight);
    sqlite3_bind_int(addStmt, 5, dia_pcs);
    sqlite3_bind_int(addStmt, 6, dia_wt);
    sqlite3_bind_int(addStmt, 7, cst_pcs);
    sqlite3_bind_int(addStmt, 8, cst_wt);
    
   
    sqlite3_bind_blob(addStmt, 9,  [imageData1 bytes], (int)[imageData1 length], SQLITE_STATIC);
    sqlite3_bind_blob(addStmt, 10, [imageData2 bytes], (int)[imageData2 length], SQLITE_STATIC);
    sqlite3_bind_blob(addStmt, 11, [imageData3 bytes], (int)[imageData3 length], SQLITE_STATIC);
    
    sqlite3_bind_int(addStmt, 12, in_stock_status);
    sqlite3_bind_int(addStmt, 13, collection_id);
    sqlite3_bind_int(addStmt, 14, metal);
    
    sqlite3_bind_int(addStmt, 15, karat);
    sqlite3_bind_int(addStmt, 16, size);
    sqlite3_bind_int(addStmt, 17, price);
    
    sqlite3_bind_int(addStmt, 18, quality_price);
    sqlite3_bind_int(addStmt, 19, quality);
    sqlite3_bind_int(addStmt, 20, category_id);
    
    
    sqlite3_bind_text(addStmt, 21, [style_id UTF8String], -1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 22, [slash_no UTF8String], -1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 23, [location_id UTF8String], -1, SQLITE_STATIC);
  
    sqlite3_bind_text(addStmt, 24, [sub_category_id UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt, 25, [created_at UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_bind_text(addStmt, 26, [updated_at UTF8String], -1, SQLITE_TRANSIENT);
    
 
    if(SQLITE_DONE != sqlite3_step(addStmt))
        
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        proID = (int)sqlite3_last_insert_rowid(database);
    NSLog(@"----> %ld",(long)proID);
    
    sqlite3_reset(addStmt);

    
}

-(void)addCollection_coll_id:(int)coll_id addCollection_name:(NSString *)name addCollection_image:(NSString*)image addCollection_sequence:(int)sequence addCollection_image_pos:(NSString*)image_pos addCollection_is_new_collection:(NSString*)is_new_collection addCollection_section:(NSString*)section addCollection_background:(NSString*)background addCollection_collection_id:(int)collection_id addCollection_status:(int)status addCollection_created_at:(NSString*)created_at addCollection_updated_at:(NSString*)updated_at
{
    int record_exists = 0;
    
    NSData *  collImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
    
    NSString *sqlStrrecord = [NSString stringWithFormat:@"select * from COLLECTION_MASTER where coll_id='%d'",coll_id];
    
    const char *sqlsqlRecord = [sqlStrrecord cStringUsingEncoding:NSUTF8StringEncoding];
    
    if(sqlite3_prepare_v2(database, sqlsqlRecord, -1, &detailStmt, NULL) != SQLITE_OK)
        
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        record_exists=1;
        const char * sql = "delete from COLLECTION_MASTER where coll_id = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"error while creating delete statement.'%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_int(deleteStmt, 1, coll_id);
        
        if (SQLITE_DONE!= sqlite3_step(deleteStmt))
            NSAssert1(0, @"errror while deleting.'%s'", sqlite3_errmsg(database));
    }
   
    const char *sql = "insert into COLLECTION_MASTER(coll_id,name,image,sequence,image_pos,is_new_collection,section,background,collection_id,status,created_at,updated_at) Values(?,?,?,?,?,?,?,?,?,?,?,?)";
    
    if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    
    
    sqlite3_bind_int(addStmt, 1, coll_id);
    sqlite3_bind_text(addStmt, 2, [name UTF8String], -1, SQLITE_STATIC);
    
    sqlite3_bind_blob(addStmt, 3, [collImage bytes], (int)[collImage length], SQLITE_STATIC);
    
    sqlite3_bind_int(addStmt, 4, sequence);
    
    
    sqlite3_bind_text(addStmt, 5, [image_pos UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 6, [is_new_collection UTF8String],-1, SQLITE_STATIC);
     sqlite3_bind_text(addStmt, 7, [section UTF8String],-1, SQLITE_STATIC);
   
    sqlite3_bind_text(addStmt, 8, [background UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 9, collection_id);
    sqlite3_bind_int(addStmt, 10, status);
    sqlite3_bind_text(addStmt, 11, [created_at UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 12, [updated_at UTF8String],-1, SQLITE_STATIC);

    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        coll_id = (int)sqlite3_last_insert_rowid(database);
    NSLog(@"----> %ld",(long)coll_id);
    
    sqlite3_reset(addStmt);
   
}

-(void)addCategory_cat_id:(int)cat_id addCategory_name:(NSString*)name addCategory_image:(NSString*)image addCategory_sequence:(int)sequence addCategory_image_pos:(NSString*)image_pos addCategory_is_new_collection:(NSString*)is_new_collection addCategory_section:(NSString*)section addCategory_background:(NSString*)background addCategory_status:(int)status addCategory_parent_id:(NSString*)parent_id addCategory_category_id:(int)category_id addCategory_created_at:(NSString*)created_at addCategory_updated_at:(NSString*)updated_at
{
    int record_exists = 0;
    
    NSData *  catImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
    NSString *sqlStrrecord = [NSString stringWithFormat:@"select * from CATEGORY_MASTER where cat_id='%d'",cat_id];
    
    const char *sqlsqlRecord = [sqlStrrecord cStringUsingEncoding:NSUTF8StringEncoding];
    
    if(sqlite3_prepare_v2(database, sqlsqlRecord, -1, &detailStmt, NULL) != SQLITE_OK)
        
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        record_exists=1;
        const char * sql = "delete from CATEGORY_MASTER where cat_id = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"error while creating delete statement.'%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_int(deleteStmt, 1, cat_id);
        
        if (SQLITE_DONE!= sqlite3_step(deleteStmt))
            NSAssert1(0, @"errror while deleting.'%s'", sqlite3_errmsg(database));
    }
    
   
    const char *sql = "insert into CATEGORY_MASTER(cat_id,name,image,sequence,image_pos,is_new_collection,section,background,status,parent_id,category_id,created_at,updated_at) Values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    
    
    sqlite3_bind_int(addStmt, 1, cat_id);
    sqlite3_bind_text(addStmt, 2, [name UTF8String], -1, SQLITE_STATIC);
    sqlite3_bind_blob(addStmt, 3, [catImage bytes], (int)[catImage length], SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 4, sequence);
    
    sqlite3_bind_text(addStmt, 5, [image_pos UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 6, [is_new_collection UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 7, [section UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 8, [background UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 9, status);
    
    sqlite3_bind_text(addStmt, 10, [parent_id UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 11, category_id );
    sqlite3_bind_text(addStmt, 12, [created_at UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 13, [updated_at UTF8String],-1, SQLITE_STATIC);
    
  
    
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        cate_ID = (int)sqlite3_last_insert_rowid(database);
    NSLog(@"----> %ld",(long)cate_ID);
    
    sqlite3_reset(addStmt);
    
    
}

#pragma add Data to table Add to Cart

-(void)addToCart_productid:(int)productID addToCart_quantity:(int)quantity addToCart_userEmail:(NSString *)useremail
{
    int record_exists = 0;
    

    NSString *sqlStrrecord = [NSString stringWithFormat:@"select * from AddToCart where productID='%d'",productID];
    
    const char *sqlsqlRecord = [sqlStrrecord cStringUsingEncoding:NSUTF8StringEncoding];
    
    if(sqlite3_prepare_v2(database, sqlsqlRecord, -1, &detailStmt, NULL) != SQLITE_OK)
        
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        record_exists=1;
        const char * sql = "delete from AddToCart where productID = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"error while creating delete statement.'%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_int(deleteStmt, 1, productID);
        
        if (SQLITE_DONE!= sqlite3_step(deleteStmt))
            
            NSAssert1(0, @"errror while deleting.'%s'", sqlite3_errmsg(database));
    }
    
    
    //CREATE TABLE "AddToCart" ("ID" integer PRIMARY KEY AUTOINCREMENT,"" INTEGER UNIQUE , "" INTEGER DEFAULT 1, "" VARCHAR)
    
    const char *sql = "insert into AddToCart(productID,quantity,userEmail) Values(?,?,?)";
    
    if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
        
        NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    
    
    sqlite3_bind_int(addStmt, 1, productID);
   
    sqlite3_bind_int(addStmt, 4, quantity);
    
    sqlite3_bind_text(addStmt, 5, [useremail UTF8String],-1, SQLITE_STATIC);
    
    
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        cate_ID = (int)sqlite3_last_insert_rowid(database);
    //NSLog(@"----> %ld",(long)cate_ID);
    
    sqlite3_reset(addStmt);
}

#pragma add wishlistData

-(void)addToWishlist_productid:(int)productID addToWishlist_quantity:(int)quantity addToWishlist_userEmail:(NSString *)useremail
{
    int record_exists = 0;
    
    
    NSString *sqlStrrecord = [NSString stringWithFormat:@"select * from AddToWishlist where productID='%d'",productID];
    
    const char *sqlsqlRecord = [sqlStrrecord cStringUsingEncoding:NSUTF8StringEncoding];
    
    if(sqlite3_prepare_v2(database, sqlsqlRecord, -1, &detailStmt, NULL) != SQLITE_OK)
        
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        record_exists=1;
        const char * sql = "delete from AddToWishlist where productID = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"error while creating delete statement.'%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_int(deleteStmt, 1, productID);
        
        if (SQLITE_DONE!= sqlite3_step(deleteStmt))
            
            NSAssert1(0, @"errror while deleting.'%s'", sqlite3_errmsg(database));
    }
    
    
    //CREATE TABLE "AddToCart" ("ID" integer PRIMARY KEY AUTOINCREMENT,"" INTEGER UNIQUE , "" INTEGER DEFAULT 1, "" VARCHAR)
    
    const char *sql = "insert into AddToWishlist(productID,quantity,userEmail) Values(?,?,?)";
    
    if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
        
        NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    
    
    sqlite3_bind_int(addStmt, 1, productID);
    
    sqlite3_bind_int(addStmt, 4, quantity);
    
    sqlite3_bind_text(addStmt, 5, [useremail UTF8String],-1, SQLITE_STATIC);
    
    
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        cate_ID = (int)sqlite3_last_insert_rowid(database);
   
    
    sqlite3_reset(addStmt);
}
#pragma mark SELECT QUERY FOR category Data

-(NSMutableArray *)getCategoryData:(NSUInteger)category_id
{
    NSMutableArray  *categoryArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSString *string = @"";
    
    string = [NSString stringWithFormat:@"Select * From STYLE_MASTER where category_id = %lu",(unsigned long)category_id];
    
    const char *sql= [string cStringUsingEncoding:NSUTF8StringEncoding];
    
    
    if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        
        
        NSNumber *pid = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 1)];
        
        NSMutableString *proid = [[NSMutableString alloc] initWithFormat:@"%d",[pid intValue]];
        
        NSMutableString *name = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 2)];
        
        NSNumber *piece = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 2)];
        
        NSMutableString *pieces = [[NSMutableString alloc] initWithFormat:@"%d",[piece intValue]];
        
        NSNumber *wt = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 4)];
        
        NSMutableString *weight = [[NSMutableString alloc] initWithFormat:@"%d",[wt intValue]];
        
        NSNumber *dpc = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 5)];
        
        NSMutableString *dia_pcs = [[NSMutableString alloc] initWithFormat:@"%d",[dpc intValue]];
        
        
        NSNumber *dwt = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 6)];
        
        NSMutableString *dia_wt = [[NSMutableString alloc] initWithFormat:@"%d",[dwt intValue]];
        
        NSNumber *cpcs = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 7)];
        
        NSMutableString *cst_pcs = [[NSMutableString alloc] initWithFormat:@"%d",[cpcs intValue]];
        
        
        NSNumber *cwt = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 8)];
        
        NSMutableString *cst_wt = [[NSMutableString alloc] initWithFormat:@"%d",[cwt intValue]];
        
        NSData *image1 = [[NSData alloc] initWithBytes:sqlite3_column_blob(detailStmt, 9) length:sqlite3_column_bytes(detailStmt, 9)];
        NSData *image2 = [[NSData alloc] initWithBytes:sqlite3_column_blob(detailStmt, 10) length:sqlite3_column_bytes(detailStmt, 10)];
        NSData *image3 = [[NSData alloc] initWithBytes:sqlite3_column_blob(detailStmt, 11) length:sqlite3_column_bytes(detailStmt, 11)];
        
        NSNumber *instk = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 12)];
        
        NSMutableString *in_stock_status = [[NSMutableString alloc] initWithFormat:@"%d",[instk intValue]];
        
        NSNumber *catid = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 20)];
        
        NSMutableString *category_id = [[NSMutableString alloc] initWithFormat:@"%d",[catid intValue]];
        
        NSNumber *mtl = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 14)];
        
        NSMutableString *metal = [[NSMutableString alloc] initWithFormat:@"%d",[mtl intValue]];
        
        NSNumber *krt = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 15)];
        
        NSMutableString *karat = [[NSMutableString alloc] initWithFormat:@"%d",[krt intValue]];
        
        NSNumber *szd = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 16)];
        
        NSMutableString *size = [[NSMutableString alloc] initWithFormat:@"%d",[szd intValue]];
        
        NSNumber *qlty = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 17)];
        
        NSMutableString *quality = [[NSMutableString alloc] initWithFormat:@"%d",[qlty intValue]];
        
        NSNumber *prc = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 18)];
        
        NSMutableString *price = [[NSMutableString alloc] initWithFormat:@"%d",[prc intValue]];
        
        NSNumber *qltyprc=[[NSNumber alloc]initWithInt:sqlite3_column_int(detailStmt, 19)];
        
        NSMutableString *quality_price=[[NSMutableString alloc]initWithFormat:@"%d",[qltyprc intValue]];
        
        NSMutableString *style_id = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 21)];
        
        NSMutableString *slash_no = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 22)];
        
        NSMutableString *location_id = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 23)];
        
        NSMutableString *created_at = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 25)];
        NSMutableString *updated_at = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 26)];
        
        
        [dict setValue:proid forKey:@"proid"];
        [dict setValue:name forKey:@"name"];
        
        [dict setValue:pieces forKey:@"pieces"];
        [dict setValue:weight forKey:@"weight"];
        [dict setValue:dia_pcs forKey:@"dia_pcs"];
        [dict setValue:dia_wt forKey:@"dia_wt"];
        [dict setValue:cst_pcs forKey:@"cst_pcs"];
        [dict setValue:cst_wt forKey:@"cst_wt"];
        [dict setValue:image1 forKey:@"image1"];
        [dict setValue:image2 forKey:@"image2"];
        [dict setValue:image3 forKey:@"image3"];
        
        [dict setValue:in_stock_status forKey:@"in_stock_status"];
        
        [dict setValue:category_id forKey:@"category_id"];
        [dict setValue:metal forKey:@"metal"];
        [dict setValue:karat forKey:@"karat"];
        [dict setValue:size forKey:@"size"];
        [dict setValue:quality forKey:@"quality"];
        
        [dict setValue:price forKey:@"price"];
        [dict setValue:quality_price forKey:@"quality_price"];
        [dict setValue:style_id forKey:@"style_id"];
        [dict setValue:slash_no forKey:@"slash_no"];
        
        [dict setValue:location_id forKey:@"location_id"];
        [dict setValue:created_at forKey:@"created_at"];
        [dict setValue:updated_at forKey:@"updated_at"];
        
        
        [categoryArr addObject:[dict copy]];
        [[NSUserDefaults standardUserDefaults] setObject:categoryArr forKey:@"categoryListingData"];
        
        
    }
    //Reset the detail statement.
    sqlite3_reset(detailStmt);
    return categoryArr;
}




#pragma mark SELECT QUERY FOR collectionData

-(NSMutableArray *)getCollectionData:(NSUInteger)collectionId
{
    NSMutableArray  *collectionarray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSString *string = @"";
    
    string = [NSString stringWithFormat:@"Select * From STYLE_MASTER where collection_id = %lu",(unsigned long)collectionId];
  
    const char *sql= [string cStringUsingEncoding:NSUTF8StringEncoding];
    
    
    if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        

        NSNumber *pid = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 1)];
        
        NSMutableString *proid = [[NSMutableString alloc] initWithFormat:@"%d",[pid intValue]];
        
        NSMutableString *name = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 2)];
        
        NSNumber *piece = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 2)];
        
        NSMutableString *pieces = [[NSMutableString alloc] initWithFormat:@"%d",[piece intValue]];
       
        NSNumber *wt = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 4)];
        
        NSMutableString *weight = [[NSMutableString alloc] initWithFormat:@"%d",[wt intValue]];
        
        NSNumber *dpc = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 5)];
        
        NSMutableString *dia_pcs = [[NSMutableString alloc] initWithFormat:@"%d",[dpc intValue]];
        
        
        NSNumber *dwt = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 6)];
        
        NSMutableString *dia_wt = [[NSMutableString alloc] initWithFormat:@"%d",[dwt intValue]];
        
        NSNumber *cpcs = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 7)];
        
        NSMutableString *cst_pcs = [[NSMutableString alloc] initWithFormat:@"%d",[cpcs intValue]];
        
        
        NSNumber *cwt = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 8)];
        
        NSMutableString *cst_wt = [[NSMutableString alloc] initWithFormat:@"%d",[cwt intValue]];
     
        NSData *image1 = [[NSData alloc] initWithBytes:sqlite3_column_blob(detailStmt, 9) length:sqlite3_column_bytes(detailStmt, 9)];
        NSData *image2 = [[NSData alloc] initWithBytes:sqlite3_column_blob(detailStmt, 10) length:sqlite3_column_bytes(detailStmt, 10)];
        NSData *image3 = [[NSData alloc] initWithBytes:sqlite3_column_blob(detailStmt, 11) length:sqlite3_column_bytes(detailStmt, 11)];
        
        NSNumber *instk = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 12)];
        
        NSMutableString *in_stock_status = [[NSMutableString alloc] initWithFormat:@"%d",[instk intValue]];
     
        NSNumber *colid = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 13)];
        
        NSMutableString *collection_id = [[NSMutableString alloc] initWithFormat:@"%d",[colid intValue]];
   
        NSNumber *mtl = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 14)];
        
        NSMutableString *metal = [[NSMutableString alloc] initWithFormat:@"%d",[mtl intValue]];
  
        NSNumber *krt = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 15)];
        
        NSMutableString *karat = [[NSMutableString alloc] initWithFormat:@"%d",[krt intValue]];
 
        NSNumber *szd = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 16)];
        
        NSMutableString *size = [[NSMutableString alloc] initWithFormat:@"%d",[szd intValue]];

        NSNumber *qlty = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 17)];
        
        NSMutableString *quality = [[NSMutableString alloc] initWithFormat:@"%d",[qlty intValue]];
        
        NSNumber *prc = [[NSNumber alloc] initWithInt:sqlite3_column_int(detailStmt, 18)];
        
        NSMutableString *price = [[NSMutableString alloc] initWithFormat:@"%d",[prc intValue]];
        
        NSNumber *qltyprc=[[NSNumber alloc]initWithInt:sqlite3_column_int(detailStmt, 19)];
        
        NSMutableString *quality_price=[[NSMutableString alloc]initWithFormat:@"%d",[qltyprc intValue]];
       
        NSMutableString *style_id = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 21)];
        
        NSMutableString *slash_no = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 22)];
        
        NSMutableString *location_id = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 23)];

        NSMutableString *created_at = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 25)];
        NSMutableString *updated_at = [[NSMutableString alloc] initWithUTF8String:(const char *)sqlite3_column_text(detailStmt, 26)];
     
        
        [dict setValue:proid forKey:@"proid"];
        [dict setValue:name forKey:@"name"];
        [dict setValue:pieces forKey:@"pieces"];
        [dict setValue:weight forKey:@"weight"];
        [dict setValue:dia_pcs forKey:@"dia_pcs"];
        [dict setValue:dia_wt forKey:@"dia_wt"];
        [dict setValue:cst_pcs forKey:@"cst_pcs"];
        [dict setValue:cst_wt forKey:@"cst_wt"];
        [dict setValue:image1 forKey:@"image1"];
        [dict setValue:image2 forKey:@"image2"];
        [dict setValue:image3 forKey:@"image3"];
        [dict setValue:in_stock_status forKey:@"in_stock_status"];
        
        [dict setValue:collection_id forKey:@"collection_id"];
        [dict setValue:metal forKey:@"metal"];
        [dict setValue:karat forKey:@"karat"];
        [dict setValue:size forKey:@"size"];
        [dict setValue:quality forKey:@"quality"];
        [dict setValue:price forKey:@"price"];
        [dict setValue:quality_price forKey:@"quality_price"];
        [dict setValue:style_id forKey:@"style_id"];
        [dict setValue:slash_no forKey:@"slash_no"];
        
        [dict setValue:location_id forKey:@"location_id"];
        [dict setValue:created_at forKey:@"created_at"];
        [dict setValue:updated_at forKey:@"updated_at"];
        
   
        
        [collectionarray addObject:[dict copy]];
        [[NSUserDefaults standardUserDefaults] setObject:collectionarray forKey:@"collectionListingData"];
    }
    //Reset the detail statement.
    sqlite3_reset(detailStmt);
    return collectionarray;
}


@end
